

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/widget/base.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {

  TextEditingController _phoneEditingController;
  TextEditingController _msgEditingController;
  TextEditingController _oldPwdEditingController;
  TextEditingController _newPwdEditingController;

  bool isAgree = false;

  @override
  void initState() {
    super.initState();
    _phoneEditingController = new TextEditingController();
    _msgEditingController = new TextEditingController();
    _oldPwdEditingController = new TextEditingController();
    _newPwdEditingController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneEditingController.dispose();
    _msgEditingController.dispose();
    _oldPwdEditingController.dispose();
    _newPwdEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseWidget.getBaseAppBar(
          "忘记密码",
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
            _buildInputOldPwd(),
            SizedBox(height: 10,),
            _buildInputNewPwd(),
            SizedBox(height: 68,),
            _buildCompleteButton(),
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

  Widget _buildInputOldPwd(){
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
                      hintText: "请输入新密码",
                      textEditingController: _oldPwdEditingController,
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

  Widget _buildInputNewPwd(){
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
                      hintText: "请确认密码",
                      textEditingController: _oldPwdEditingController,
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

  Widget _buildCompleteButton(){
    return BaseWidget.getBaseButton(text: "注册",width: 315,height: 48, onPressed: (){

    });
  }

}
