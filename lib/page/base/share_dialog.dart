import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/utils/gallery.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareDialog extends StatefulWidget {
  @override
  _ShareDialogState createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 176,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("分享到",style: MyTextStyle.TEXT_S14_C00_W6,),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset("images/share_wechat.png",width: 46,height: 46,),
                    SizedBox(height: 8,),
                    Text("微信",style: MyTextStyle.TEXT_S14_C99,),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("images/share_qq.png",width: 46,height: 46,),
                    SizedBox(height: 8,),
                    Text("QQ",style: MyTextStyle.TEXT_S14_C99,),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("images/share_weibo.png",width: 46,height: 46,),
                    SizedBox(height: 8,),
                    Text("微博",style: MyTextStyle.TEXT_S14_C99,),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShareSaveDialog extends StatefulWidget {

  String shareUrl;
  String title;

  ShareSaveDialog(this.shareUrl,this.title);

  @override
  _ShareSaveDialogState createState() => _ShareSaveDialogState();
}

class _ShareSaveDialogState extends State<ShareSaveDialog> {

  GlobalKey _saveKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(icon: Icon(Icons.cancel,color: MyColors.GRAY_TEXT_99,), onPressed: (){
                  Navigator.pop(context);
                }),
              ),
            ),
            SizedBox(height: 5,),
            RepaintBoundary(
              key: _saveKey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: 300,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Text("澳亚财经",style: MyTextStyle.TEXT_S16_C33_W6,),
                    SizedBox(height: 30,),
                    QrImage(
                      data: "${widget.shareUrl}",
                      version: QrVersions.auto,
                      size: 200,
                      embeddedImage: AssetImage('images/ic_launcher.png'),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(20,20),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("${widget.title}",style: MyTextStyle.TEXT_S14_C33,textAlign: TextAlign.center,),
                    SizedBox(height: 20,),
                    Text("扫码查看详情，了解更多区块链快讯",style: MyTextStyle.TEXT_S12_C99,textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            BaseWidget.getBaseButton(text: "保存到相册", width :300,onPressed: (){
              GalleryUtils().saveImageForWidget(_saveKey);
            })
          ],
        )
      ),
    );
  }
}
