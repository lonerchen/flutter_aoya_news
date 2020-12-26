

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _phoneEditingController;
  TextEditingController _msgEditingController;
  TextEditingController _pwdEditingController;
  TextEditingController _inviteEditingController;

  bool isAgree = false;

  @override
  void initState() {
    super.initState();
    _phoneEditingController = new TextEditingController();
    _msgEditingController = new TextEditingController();
    _pwdEditingController = new TextEditingController();
    _inviteEditingController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneEditingController.dispose();
    _msgEditingController.dispose();
    _pwdEditingController.dispose();
    _inviteEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseWidget.getBaseAppBar(
          "注册账号",
        color: Colors.white,
        textColor: MyColors.BLACK_TEXT_33

      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            _buildInputPhone(),
            SizedBox(height: 10,),
            _buildInputMsg(),
            SizedBox(height: 10,),
            _buildInputPwd(),
            SizedBox(height: 10,),
            _buildInputInvite(),
            SizedBox(height: 14,),
            _buildAgree(),
            SizedBox(height: 68,),
            _buildRegisterButton(),
            SizedBox(height: 20,),
            _buildLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputPhone(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30,),
//          Image.asset("images/login_phone.png",width: 20,height: 20,),
//          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: Column(
                children: [
                  Expanded(
                    child: BaseWidget.getDefaultTextField(
                        hintText: "请输入手机号",
                        textEditingController: _phoneEditingController,
                        fontSize: 14,
                    ),
                  ),
                  Divider(height: 1,),
                ],
              ),
            ),
          ),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  Widget _buildInputMsg(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30,),
//          Image.asset("images/login_msg.png",width: 20,height: 20,),
//          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: BaseWidget.getDefaultTextField(hintText: "请输入验证码",fontSize: 14,textEditingController: _msgEditingController)),
                        BaseWidget.getBaseButton(
                            text: "获取验证码",
                            width: 98,
                            fontSize:12,
                            height: 33,
                            onPressed: (){

                            }
                        ),
//                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Divider(height: 1,),
                ],
              ),
            ),
          ),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  Widget _buildInputPwd(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30,),
//          Image.asset("images/login_phone.png",width: 20,height: 20,),
//          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: Column(
                children: [
                  Expanded(
                    child: BaseWidget.getDefaultTextField(
                      hintText: "请输入6-16位的数字字母组合密码",
                      textEditingController: _pwdEditingController,
                      fontSize: 14,
                    ),
                  ),
                  Divider(height: 1,),
                ],
              ),
            ),
          ),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  Widget _buildInputInvite(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30,),
//          Image.asset("images/login_phone.png",width: 20,height: 20,),
//          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 57,
              child: Column(
                children: [
                  Expanded(
                    child: BaseWidget.getDefaultTextField(
                      hintText: "请输入邀请码（选填）",
                      textEditingController: _pwdEditingController,
                      fontSize: 14,
                    ),
                  ),
                  Divider(height: 1,),
                ],
              ),
            ),
          ),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  ///同意协议
  Widget _buildAgree(){
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30,),
          Checkbox(value: isAgree, onChanged: (agree){
            setState(() {
              isAgree = agree;
            });
          }),
          Text("我已阅读和同意",style: MyTextStyle.TEXT_S10_C99,),
          Text("《澳亚财经App服务协议》",style: MyTextStyle.TEXT_S10_CTIT,),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(){
    return BaseWidget.getBaseButton(text: "注册",width: 315,height: 48, onPressed: (){

    });
  }

  Widget _buildLogin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("已有账号，",style: MyTextStyle.TEXT_S14_C99,),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Text("立即登录",style: MyTextStyle.TEXT_S14_CTIT,)),
      ],
    );
  }



}
