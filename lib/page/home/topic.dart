import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';
import 'package:flutter_aoya_news/model/topic.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:oktoast/oktoast.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> with AutomaticKeepAliveClientMixin  {

  int filterIndex = 0;
  List<String> filterList = [
    "按更新时间",
    "按创建时间",
  ];
  List<Topic> topicList = [
  ];
  RefreshController _refreshController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = new RefreshController();
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: (){
          _refresh();
          _refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                _buildFilter(),
                SizedBox(height: 15,),
                _buildGrid(),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilter(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        children: List.generate(filterList.length, (index) => InkWell(
          onTap: (){
            _sort(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: index == filterIndex ? MyColors.THEME_COLORS : MyColors.GRAY_TEXT_C7),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Text(
                filterList[index],
              style: index == filterIndex ? MyTextStyle.TEXT_S12_CTIT : MyTextStyle.TEXT_S12_C99,
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildGrid(){
    return Container(
      child: GridView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: topicList.length > 0 ? 2 : 1,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 1.2,
        ),
        children: topicList.length > 0 ? _buildItem() : BaseWidget.getEmptyWidget(),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(topicList.length, (index) => InkWell(
      onTap: (){
        showToast("暂无内容，敬请期待～");
      },
      child: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 167,
              decoration: BoxDecoration(
                color: MyColors.GRAY_TEXT_99,
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(topicList[index].image)
                )
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6),)
                  ),
                  child: Center(
                    child: Text(
                      "澳亚专题",
                      style: MyTextStyle.TEXT_S12_WHITE,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 13,),
            Text("${topicList[index].title}",style: MyTextStyle.TEXT_S14_C33,),
          ],
        ),
      ),
    ));
  }

  _refresh(){
    Future.delayed(Duration.zero,()async{
      var result = await DioUtils.getInstance().get(URL.homeTab,params: <String,dynamic>{
        "id":3,
        "page":1,
      });
      topicList = Topic.formJsonList(result["data"]);
      print(result);
      if(mounted)
      setState(() {

      });
    });
  }

  _sort(int index){
    setState(() {
      filterIndex = index;
      if(filterIndex == 0){
        //冒泡排序
        Topic topic;
        for(int i = 0;i < topicList.length - 1 ; i++){
          for(int j = 0; j < topicList.length - i - 1; j++){
            if(DateTime.parse(topicList[j].updatedAt).millisecondsSinceEpoch > DateTime.parse(topicList[j + 1].updatedAt).millisecondsSinceEpoch){
              topic = topicList[j];
              topicList[j] = topicList[j+1];
              topicList[j+1] = topic;
            }
          }
        }
      }else{
        //冒泡排序
        Topic topic;
        for(int i = 0;i < topicList.length - 1 ; i++){
          for(int j = 0; j < topicList.length - i - 1; j++){
            if(DateTime.parse(topicList[j].createdAt).millisecondsSinceEpoch > DateTime.parse(topicList[j + 1].createdAt).millisecondsSinceEpoch){
              topic = topicList[j];
              topicList[j] = topicList[j+1];
              topicList[j+1] = topic;
            }
          }
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

}
