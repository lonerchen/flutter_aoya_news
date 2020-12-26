
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';
import 'package:flutter_aoya_news/model/tab.dart';
import 'package:flutter_aoya_news/page/base/share_dialog.dart';
import 'package:flutter_aoya_news/page/base/web.dart';
import 'package:flutter_aoya_news/utils/date.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:flutter_html/flutter_html.dart';


class ContentDetailsPage extends StatefulWidget {

  final int id;

  ContentDetailsPage(this.id);

  @override
  _ContentDetailsPageState createState() => _ContentDetailsPageState();

}

class _ContentDetailsPageState extends State<ContentDetailsPage> {

  TabContentDetails _tabContentDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,()async{
      var result = await DioUtils.getInstance().post(URL.newsDetails,body: <String,dynamic>{
        "id":widget.id,
      });
      _tabContentDetails = TabContentDetails.fromJson(result);
      setState(() {

      });
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: BaseWidget.getBaseAppBar(
        "",
        color: Colors.white,
        actions: [
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context) => ShareSaveDialog("https://www.aoya.news/special/detail/index?id=${_tabContentDetails.id}",_tabContentDetails.title));

            },
            child: Container(
              padding: EdgeInsets.only(right: 15),
                child: Image.asset("images/title_share.png",width: 24,height: 24,),
            ),
          ),
        ]
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 10,),
            _buildTime(),
            SizedBox(height: 15,),
            _buildContent()
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(){
    return Text("${_tabContentDetails?.title??"加载中..."}",style: MyTextStyle.TEXT_S16_C33,);
  }

  Widget _buildTime(){
    return Text("来自：${_tabContentDetails?.author??"加载中..."} ${DateUtils.formatAgo(DateTime.parse(_tabContentDetails?.createdAt??"2020-01-01"
        ""))}",style: MyTextStyle.TEXT_S10_C99,);
  }

  Widget _buildContent(){
    return Expanded(
      child: SingleChildScrollView(
        child: Html(
          data: _tabContentDetails?.content??"加载中...",
          customTextStyle: (dom,baseStyle){
            return baseStyle.merge(TextStyle(fontSize: 15));
          },
          onLinkTap: (url) {
//                  _launchUrl(url);
//                  print("Opening $url...");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WebViewPage("$url")
            ));
          },
        ),
      ),
    );
  }

}
