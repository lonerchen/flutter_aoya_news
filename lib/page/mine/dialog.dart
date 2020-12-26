

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

class EditNameDialog extends StatefulWidget {
  @override
  _EditNameDialogState createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {

  TextEditingController nameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 290,
          height: 246,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("修改昵称",style: MyTextStyle.TEXT_S18_C33_W6,),
              Container(
                width: 237,
                height: 39,
                decoration: BoxDecoration(
                  color: MyColors.GRAY_TEXT_EE,
                  borderRadius: BorderRadius.circular(19.5),
                ),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(fontSize: 16,color: MyColors.BLACK_TEXT_22),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: MyColors.GRAY_TEXT_EE,
                    filled: true,
                    hintStyle: TextStyle(color: MyColors.GRAY_TEXT_99),
                    hintText: "输入新昵称",
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(19.5), // 设置圆角
                        borderSide: BorderSide.none // 设置不要边框
                    ),
                  ),
                ),
              ),
              BaseWidget.getBaseButton(text: "确定",width: 90,height: 36, onPressed: (){
                Navigator.pop(context,nameController.text);
              })
            ],
          ),
        ),
      ),
    );
  }
}


class VerifyFailDialog extends StatefulWidget {
  @override
  _VerifyFailDialogState createState() => _VerifyFailDialogState();
}

class _VerifyFailDialogState extends State<VerifyFailDialog> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 290,
          height: 246,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/verify_fail.png",width: 24,height: 24,),
                  SizedBox(width: 9,),
                  Text("审核失败",style: MyTextStyle.TEXT_S20_C52_W6,),
                ],
              ),
              Text("理由：照片太模糊，看不清",style: MyTextStyle.TEXT_S18_C66,),
              BaseWidget.getBaseButton(text: "重新认证",width: 120,height: 36, onPressed: (){
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
