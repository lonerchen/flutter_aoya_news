

import 'package:flutter/material.dart';

class UserModel  extends ChangeNotifier {

  UserInfo userInfo = new UserInfo();


}

class UserInfo{

  int uid = -1;
  String avatar;//头像
  String name;//名称
  bool isJoin = true;//是否入驻专栏
  bool isReal = true;//是否实名认证


}