

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';
import 'package:flutter_aoya_news/model/hot.dart';
import 'package:flutter_aoya_news/page/home/content_details.dart';
import 'package:flutter_aoya_news/utils/date.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:oktoast/oktoast.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchController;

  String searchText = "";//开始搜索之后变成1

  int page = 1;
  int size = 20;

  RefreshController _searchRefreshController;

  //搜索历史记录
  List<String> recordList = List();

  //热门搜索记录
  List<String> hotList = [
    "美国大选","以太坊行情","金色财经","澳亚财经"
  ];

  List<HotBean> hotNewsList = [
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = new TextEditingController(text:"");
    _searchRefreshController = new RefreshController();
    _readRecord();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
    _searchRefreshController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 44,),
            _buildSearchBar(),
            searchText == "" ? _buildUnSearch() : _buildNewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          //搜索框
          Expanded(
            child: Container(
              height: 36,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: MyColors.GRAY_TEXT_EE,
                borderRadius: BorderRadius.circular(17.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 15,),
                  Expanded(
                    child: Container(
                      height: 20,
                      child: TextField(
                        controller: searchController,
                        maxLines: 1,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(color: MyColors.BLACK_TEXT_22,fontSize: 14),
                        onSubmitted: (text){
                          if(text != ""){
                            searchText = text;
                            if(!recordList.contains(text)) {
                              recordList.add(text);
                            }
                            _saveRecord();
                            this._startSearch(text);
                          }else{
                            searchText = "";
                            setState(() {
                              hotNewsList = new List();
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(0),
                          hintText: "搜索资讯",
                          hintStyle: TextStyle(color: MyColors.GRAY_TEXT_99,fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      searchController.text = "";
                      searchText = "";
                      setState(() {
                        hotNewsList = new List();
                      });
                    },
                      child: Icon(Icons.cancel,color: MyColors.GRAY_TEXT_D8,size: 16,)
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 14,),
          //取消文本
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text("取消",style: MyTextStyle.TEXT_S14_CTIT,)
          ),
        ],
      ),
    );
  }

  //还没搜索
  _buildUnSearch(){
    return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("历史搜索",style: MyTextStyle.TEXT_S12_C33,),
                    Expanded(child: Container(height: 0,)),
                    InkWell(
                      onTap: (){
                        _deleteRecord();
                      },
                        child: Image.asset("images/delete.png",height: 16,width: 16,),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                _buildSearchRecord(),
                SizedBox(height: 20,),
                Text("搜索推荐",style: MyTextStyle.TEXT_S12_C33,),
                SizedBox(height: 10,),
                _buildSearchHot(),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildSearchRecord(){
    return Wrap(
      children: List.generate(recordList.length, (index) => Container(
        child: InkWell(
          onTap: (){
            searchText = recordList[index];
            _startSearch("${recordList[index]}");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
            decoration: BoxDecoration(
              color: MyColors.GRAY_TEXT_F6,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${recordList[index]}",
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildSearchHot(){
    return Wrap(
      children: List.generate(hotList.length, (index) => Container(
        child: InkWell(
          onTap: (){
            searchText = hotList[index];
            _startSearch("${hotList[index]}");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
            decoration: BoxDecoration(
              color: MyColors.GRAY_TEXT_F6,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${hotList[index]}",
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildNewsList(){
    return Expanded(
      child: Container(
        child: SmartRefresher(
          controller: _searchRefreshController,
          enablePullUp: true,
          onRefresh: (){
            if(searchText!="") {
              _startSearch(searchController.text);
            }else{
              showToast("搜索内容为空!");
            }
            _searchRefreshController.refreshCompleted();
          },
          onLoading: (){
            if(searchText!=""){
              _load(searchController.text);
            }else{
              showToast("搜索内容为空!");
            }
            _searchRefreshController.loadComplete();
          },
          child: ListView(
            children: hotNewsList.length >0 ? _buildItem() : BaseWidget.getEmptyWidget(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(hotNewsList.length, (index) => InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ContentDetailsPage(hotNewsList[index].id);
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 133,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 78,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(hotNewsList[index].thumbnail),
                      ),
                      borderRadius: BorderRadius.circular(6)
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${hotNewsList[index].title}",
                        style: MyTextStyle.TEXT_S14_C33_W6,
                        maxLines: 2,
                      ),
                      SizedBox(height: 18,),
                      Text("${hotNewsList[index].summary}",style: MyTextStyle.TEXT_S12_C66,maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 11,),
            Row(
              children: [
                Text("来自：${hotNewsList[index].author}  ${DateUtils.formatAgo(DateTime.parse(hotNewsList[index].createdAt))}",style: MyTextStyle.TEXT_S10_C99,),
                Expanded(child: Container(height: 0,)),
                Image.asset("images/news_look.png",width: 16,height: 16,),
                SizedBox(width: 6,),
                Text("${hotNewsList[index].watchCounts}",style: MyTextStyle.TEXT_S10_C99,),
              ],
            ),
            Expanded(child: Container(width: 0,)),
            Divider(height: 1,),
          ],
        ),
      ),
    ));
  }

  _startSearch(String text)async{
    var result = await DioUtils.getInstance().get(URL.search,params:<String,dynamic>{
      "page":1,
      "search":text,
    });
    hotNewsList = HotBean.formJsonList(result["data"]);
    setState(() {

    });
  }

  ///
  /// 下拉加载出来的内容
  ///
  _load(text)async{
    List<HotBean> hotBeanList;
    var result = await DioUtils.getInstance().get(URL.search,params: <String,dynamic>{
      "page":page,
      "search":text,
    });
    hotBeanList = HotBean.formJsonList(result["data"]);
    hotNewsList.addAll(hotBeanList);
    setState(() {

    });
  }



  _saveRecord()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(recordList.length > 0){
      String recordString = "";
      recordList.forEach((_data){
        recordString += ",$_data";
      });
      recordString = recordString.substring(1,recordString.length);
      prefs.setString('ptg_search_record',recordString);
    }else{
      prefs.setString('ptg_search_record',"");
      setState(() {

      });
    }
  }

  _readRecord() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String recordString = prefs.getString('ptg_search_record');
    if(recordString != null && recordString != ""){
      setState(() {
        recordList = recordString.split(",");
      });
    }
  }

  _deleteRecord() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ptg_search_record',"");
    recordList = new List();
    setState(() {

    });
  }

}
