

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/page/account/register.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

import 'forget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _phoneEditController;
  TextEditingController _msgEditController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneEditController = TextEditingController();
    _msgEditController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneEditController.dispose();
    _msgEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              _buildIcon(),
              SizedBox(height: 63,),
              _buildInputPhone(),
              SizedBox(height: 30,),
              _buildInputMsg(),
              SizedBox(height: 26,),
              _buildForgetRegister(),
              SizedBox(height: 98,),
              _buildLoginButton(),
              SizedBox(height: 28,),
              _buildLoginPwd(),
              SizedBox(height: 165,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(){
    return Image.asset("images/login_icon.png",width: 109,height: 128,);
  }
  
  Widget _buildInputPhone(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30,),
          Image.asset("images/login_phone.png",width: 20,height: 20,),
          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: Column(
                children: [
                  Expanded(
                    child: BaseWidget.getDefaultTextField(
                      hintText: "请输入手机号",
                      textEditingController: _phoneEditController,
                      maxLength: 11
                    ),
                  ),
                  Divider(height: 1,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputMsg(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30,),
          Image.asset("images/login_msg.png",width: 20,height: 20,),
          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: BaseWidget.getDefaultTextField(hintText: "请输入验证码",textEditingController: _msgEditController)),
                        BaseWidget.getBaseButton(
                            text: "获取验证码",
                            width: 98,
                            fontSize:12,
                            height: 33,
                            onPressed: (){

                            }
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Divider(height: 1,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgetRegister(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPage()));
          },
            child: Text("忘记密码",style: MyTextStyle.TEXT_S16_C33_W6,)
        ),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
          },
            child: Text("注册账号",style: MyTextStyle.TEXT_S16_C33_W6,)
        ),
      ],
    );
  }

  Widget _buildLoginButton(){
    return BaseWidget.getBaseButton(text: "登录",width: 315,height: 48, onPressed: (){

    });
  }

  Widget _buildLoginPwd(){
    return InkWell(
      onTap: (){

      },
        child: Text("账号密码登录",style: MyTextStyle.TEXT_S14_C33,));
  }

}
