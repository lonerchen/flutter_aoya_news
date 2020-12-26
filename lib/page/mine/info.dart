
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/model/user.dart';
import 'package:flutter_aoya_news/page/mine/dialog.dart';
import 'package:flutter_aoya_news/page/mine/verify.dart';
import 'package:flutter_aoya_news/utils/gallery.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:provider/provider.dart';

///
/// 用户资料
///

class EditInfoPage extends StatefulWidget {
  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseWidget.getBaseAppBar("编辑资料",color: Colors.white,iconColor: MyColors.GRAY_TEXT_66,textColor: MyColors.BLACK_TEXT_33),
      body: Consumer<UserModel>(
        builder: (context,userModel,child) => Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _buildAvatar(userModel.userInfo),
              Divider(height: 1,),
              _buildName(userModel.userInfo),
              Divider(height: 1,),
              _buildReal(userModel.userInfo),
              Divider(height: 1,),
              _buildPwd(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(UserInfo userInfo){
    return InkWell(
      onTap: (){
        GalleryUtils().showPhotoSelect(context).then((value){

        });
      },
      child: Container(
        height: 90,
        child: Row(
          children: [
            Container(
              width: 57,
              height: 57,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                image: DecorationImage(
                  image:userInfo.avatar == null ? AssetImage("images/def_avatar.png") : NetworkImage(userInfo.avatar),
                )
              ),
            ),
            Expanded(child: Container(height: 0,)),
            Text("上传头像",style: MyTextStyle.TEXT_S14_C33,),
            SizedBox(width: 20,),
            Image.asset("images/arrow_right.png",width: 6,height: 11,),
          ],
        ),
      ),
    );
  }

  Widget _buildName(UserInfo userInfo){
    return InkWell(
      onTap: (){
        showDialog(context: context,builder: (context) => EditNameDialog()).then((value){
          print(value);
        });
      },
      child: Container(
        height: 58,
        child: Row(
          children: [
            Text(userInfo.name ?? "请编辑昵称",style: MyTextStyle.TEXT_S14_C99,),
            Expanded(child: Container(height: 0,)),
            Text("修改昵称",style: MyTextStyle.TEXT_S14_C33,),
            SizedBox(width: 20,),
            Image.asset("images/arrow_right.png",width: 6,height: 11,),
          ],
        ),
      ),
    );
  }


  Widget _buildReal(UserInfo userInfo){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPage()));
      },
      child: Container(
        height: 58,
        child: Row(
          children: [
            Text(userInfo.isReal ? "已实名" : "未实名",style: MyTextStyle.TEXT_S14_C99,),
            Expanded(child: Container(height: 0,)),
            Text("实名认证",style: MyTextStyle.TEXT_S14_C33,),
            SizedBox(width: 20,),
            Image.asset("images/arrow_right.png",width: 6,height: 11,),
          ],
        ),
      ),
    );
  }


  Widget _buildPwd(){
    return Container(
      height: 58,
      child: Row(
        children: [
          Text("******",style: MyTextStyle.TEXT_S14_C99,),
          Expanded(child: Container(height: 0,)),
          Text("修改密码",style: MyTextStyle.TEXT_S14_C33,),
          SizedBox(width: 20,),
          Image.asset("images/arrow_right.png",width: 6,height: 11,),
        ],
      ),
    );
  }

}
