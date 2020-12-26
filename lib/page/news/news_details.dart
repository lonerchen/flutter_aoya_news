
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';
import 'package:flutter_aoya_news/model/news_details.dart';
import 'package:flutter_aoya_news/page/base/share_dialog.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

class NewsDetailsPage extends StatefulWidget {

  final int id;

  NewsDetailsPage(this.id);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {

  NewsDetails newsDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,()async{
      var result = await DioUtils.getInstance().post(URL.topicDetails,body: <String,dynamic>{
        "id":widget.id,
      });
      newsDetails = NewsDetails.fromJson(result);
      setState(() {

      });

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
              showDialog(context: context, builder: (context) => ShareSaveDialog("https://www.aoya.news/special/detail/news?id=${newsDetails.id}",newsDetails.title));
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
    return Text(newsDetails?.title?? "加载中...",style: MyTextStyle.TEXT_S16_C33,);
  }

  Widget _buildTime(){
    return Text(newsDetails?.createdAt?? "加载中...",style: MyTextStyle.TEXT_S10_C99,);
  }

  Widget _buildContent(){
    return Text(newsDetails?.content?? "加载中...",style: MyTextStyle.TEXT_S12_C33,);
  }

}
