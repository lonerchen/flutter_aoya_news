
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/page/mine/dialog.dart';
import 'package:flutter_aoya_news/utils/gallery.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

///
///
///
class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {

  TextEditingController realNameController;

  File idCardPositive;//正面照片
  File idCardBack;//反面照片
  File idCardMan;//手持照片

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    realNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    realNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseWidget.getBaseAppBar("编辑资料",color: Colors.white,iconColor: MyColors.GRAY_TEXT_66,textColor: MyColors.BLACK_TEXT_33),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildRealName(),
              Divider(height: 1,),
              _buildIdCard(),
              Divider(height: 1,),
              _buildIdCardImg(),
              Divider(height: 1,),
              _buildIdCardMan(),
              Divider(height: 1,),
              SizedBox(height: 10,),
              _buildUploadHint(),
              SizedBox(height: 10,),
              _buildImgHint(),
              SizedBox(height: 66,),
              _buildButton(),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRealName(){
    return Container(
      child: Row(
        children: [
          Text("真实姓名",style: MyTextStyle.TEXT_S14_C33,),
          SizedBox(width: 34,),
          Expanded(
            child: Container(
              height: 57,
              child: BaseWidget.getDefaultTextField(
                hintText: "请输入真实姓名",
                textEditingController: realNameController,
                fontSize: 14,
              ),
            ),
          ),
          Image.asset("images/arrow_right.png",width: 6,height: 10,),
        ],
      ),
    );
  }

  ///
  /// 手持身份证号码
  ///
  Widget _buildIdCard(){
    return Container(
      child: Row(
        children: [
          Text("身份证号",style: MyTextStyle.TEXT_S14_C33,),
          SizedBox(width: 34,),
          Expanded(
            child: Container(
              height: 57,
              child: BaseWidget.getDefaultTextField(
                hintText: "请输入15位或18位身份证号",
                textEditingController: realNameController,
                fontSize: 14,
              ),
            ),
          ),
          Image.asset("images/arrow_right.png",width: 6,height: 10,),
        ],
      ),
    );
  }

  ///
  /// 手持身份证正反面
  ///
  Widget _buildIdCardImg(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30,),
        Text("上传身份证照片",style: MyTextStyle.TEXT_S14_C33,),
        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                GalleryUtils().showPhotoSelect(context).then((value){
                  setState(() {
                    if(value != null) {
                      idCardPositive = value;
                    }
                  });
                });
              },
              child: Container(
                width: 158,
                height: 97,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: idCardPositive == null ? AssetImage("images/upload_img.png") : FileImage(idCardPositive),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                GalleryUtils().showPhotoSelect(context).then((value){
                  setState(() {
                    if(value != null) {
                      idCardBack = value;
                    }
                  });
                });
              },
              child: Container(
                width: 158,
                height: 97,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: idCardBack == null ? AssetImage("images/upload_img.png") : FileImage(idCardBack),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  ///
  /// 手持证件
  ///
  Widget _buildIdCardMan(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30,),
        Text("上传手持身份证照片",style: MyTextStyle.TEXT_S14_C33,),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                GalleryUtils().showPhotoSelect(context).then((value){
                  setState(() {
                    if(value != null) {
                      idCardMan = value;
                    }
                  });
                });
              },
              child: Container(
                width: 158,
                height: 97,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: idCardMan == null ? AssetImage("images/upload_img.png") : FileImage(idCardMan),
                  ),
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  Widget _buildUploadHint(){
    return Text("请严格按照要求上传材料照片，否则会造成您的认证不过审核，耽误您的宝贵时间！",style: MyTextStyle.TEXT_S12_CTIT,);
  }

  Widget _buildImgHint(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("照片要求:",style: MyTextStyle.TEXT_S12_C33_W6,),
        Text("1.照片文件大小不能超过4M！文件格式须为jpg或者png！"+
            "\n2.请确保照片无水印，无污渍，身份信息清晰，头像完整，非文字反向照片！照片请勿进行ps处理！"+
            "\n3.手持身份证照片：需要您本人手持您的身份证，确保身份证在您的胸前，不遮挡您的脸部，使身份证的信息清晰可见！"+
            "以下图片仅作为示例，请提交您本人的身份材料照片。照片勿进行PS处理！",style: MyTextStyle.TEXT_S12_C66,),
      ],
    );
  }

  Widget _buildButton(){
    return BaseWidget.getBaseButton(text: "确认无误，提交", onPressed: (){
        showDialog(context: context,builder: (context) => VerifyFailDialog()).then((value){
          print(value);
        });
    });
  }

}

