

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/utils/gallery.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

class PublishColumnPage extends StatefulWidget {
  @override
  _PublishColumnPageState createState() => _PublishColumnPageState();
}

class _PublishColumnPageState extends State<PublishColumnPage> {

  TextEditingController _themeEditingController;
  TextEditingController _contentEditingController;

  int uploadType = 1;//上传类型 0 使用模版 1 自行上传

  //专题图片
  List<String> imageGrid = [
    "images/column_img1.png",
    "images/column_img2.png",
    "images/column_img3.png",
    "images/column_img4.png",
    "images/column_img5.png",
    "images/column_img6.png",
    "images/column_img7.png",
    "images/column_img8.png",
  ];

  //当前选择了哪张图片
  int imageGridIndex = 0;

  //选择图片
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _themeEditingController = new TextEditingController();
    _contentEditingController = new TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _themeEditingController.dispose();
    _contentEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseWidget.getBaseAppBar("发布专栏",color: Colors.white,textColor:MyColors.BLACK_TEXT_33,iconColor: MyColors.GRAY_TEXT_66),
      body: Column(
        children: [
          _buildTheme(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Divider(height: 1,),
          ),
          SizedBox(height: 15,),
          _buildContent(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Divider(height: 1,),
          ),
          SizedBox(height: 60,),
          _buildImage(),
          SizedBox(height: 60,),
          _buildCompleteButton(),
        ],
      ),
    );
  }

  ///
  /// 主题
  ///
  Widget _buildTheme(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 21,),
          Text("主题*",style: MyTextStyle.TEXT_S14_C33,),
          SizedBox(width: 50,),
//          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: BaseWidget.getDefaultTextField(
                hintText: "请输入主题",
                textEditingController: _themeEditingController,
                fontSize: 14,
              ),
            ),
          ),
          Image.asset("images/arrow_right.png",width: 6,height: 10,),
          SizedBox(width: 21,),
        ],
      ),
    );
  }

  ///
  /// 内容
  ///
  Widget _buildContent(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 21,),
          Text("内容*",style: MyTextStyle.TEXT_S14_C33,),
          SizedBox(width: 50,),
//          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: BaseWidget.getDefaultTextField(
                hintText: "请输入内容",
                textEditingController: _contentEditingController,
                fontSize: 14,
              ),
            ),
          ),
          Image.asset("images/arrow_right.png",width: 6,height: 10,),
          SizedBox(width: 21,),
        ],
      ),
    );
  }
  
  Widget _buildImage(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 30,),
          Text("缩略图",style: MyTextStyle.TEXT_S14_C33,),
          SizedBox(width: 42,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  uploadType == 0 ?
                  Container(
                    width: 200,
                    height: 131,
                    decoration: BoxDecoration(
                      color: MyColors.GRAY_TEXT_F6,
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(imageGrid[imageGridIndex]),
                      ),
                    ),
                  ):
                  InkWell(
                    onTap: (){
                      GalleryUtils().showPhotoSelect(context).then((value){
                        if(value != null) {
                          setState(() {
                            file = value;
                          });
                        }
                      });
                    },
                    child: Container(
                      width: 200,
                      height: 131,
                      decoration: BoxDecoration(
                        color: MyColors.GRAY_TEXT_F6,
                        borderRadius: BorderRadius.circular(6),
                        image: file == null ? null : DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(file),
                        )
                      ),
                      child: file == null ? Center(child: Image.asset('images/custom_photo.png',width: 36,height: 30,)) : null,
                    ),
                  ),
                  SizedBox(height: 15,),
                  uploadType == 0 ? _buildImageGrid() : Text("*图片为800*600像素\n支持Jpg/Png格式，不超过2M"),
                  SizedBox(height: 26,),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            uploadType = 0;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(uploadType == 0 ? "images/radio_sel.png" : "images/radio.png",width: 14,height: 14,),
                              SizedBox(width: 6,),
                              Text("使用模版",style: uploadType == 0 ? MyTextStyle.TEXT_S12_CTIT : MyTextStyle.TEXT_S12_C99,),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 36,),

                      InkWell(
                        onTap: (){
                          setState(() {
                            uploadType = 1;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(uploadType == 1 ? "images/radio_sel.png" : "images/radio.png",width: 14,height: 14,),
                              SizedBox(width: 6,),
                              Text("自行上传",style: uploadType == 1 ? MyTextStyle.TEXT_S12_CTIT : MyTextStyle.TEXT_S12_C99,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(){
    return Container(
      margin: EdgeInsets.only(right: 21),
      child: GridView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          childAspectRatio: 1.8
        ),
        children: _buildItem(),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(imageGrid.length, (index) => InkWell(
      onTap: (){
        setState(() {
          imageGridIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: index == imageGridIndex ? MyColors.THEME_COLORS : MyColors.GRAY_TEXT_C7),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Center(
          child: Text(
            "模版$index",
            style: index == imageGridIndex ? MyTextStyle.TEXT_S12_CTIT : MyTextStyle.TEXT_S12_C99,
          ),
        ),
      ),
    ));
  }

  Widget _buildCompleteButton(){
    return BaseWidget.getBaseButton(text: "确认发布",width: 315,height: 48, onPressed: (){

    });
  }

}
