

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/value/colors.dart';

class BaseWidget{

  ///
  /// ListView中的内容为空
  ///
  static List<Widget> getEmptyWidget(){
    return [
      Container(
        height: 100,
        child: Center(
          child: Text("暂无记录!",style: TextStyle(fontSize: 14,color: MyColors.BLACK_TEXT_22),
          ),
        ),
      )
    ];
  }

  ///
  /// appBar
  ///
  //头部扩展，白色字体
  static AppBar getBaseAppBar(String title,{Color color,Color textColor,Color iconColor,List<Widget> actions,Function onBack}){
    return AppBar(
      title: title == "" ? Image.asset("images/title_icon.png",width: 104,height: 25,) : Text(title,style: TextStyle(color:textColor ??= Colors.white,fontSize: 18),),
      brightness: Brightness.light,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            iconSize: 18,
            icon: Image.asset("images/back.png",color:iconColor,width: 10,height: 17,),
            onPressed: () {
              if(onBack != null){
                onBack.call();
              }else{
                Navigator.pop(context);
              }
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: color != null ? color : MyColors.THEME_COLORS,
      elevation: 0,
    );
  }

  ///
  /// 主题色的按钮
  ///
  static Widget getBaseButton({
    @required String text,
    double fontSize = 14,
    String img,
    double width = 345,
    double height = 56,
    Color color = MyColors.THEME_COLORS,
    Color disabledColor = MyColors.BUTTON_DISABLE,
    @required VoidCallback onPressed,}
      ){
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(6)
            )
        ),
        onPressed: onPressed,
        splashColor: color,
        color: color,
        disabledColor: disabledColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            img == null ?
            Container(height:0):Image.asset("$img",width: 17,height: 17,),
            SizedBox(width: 6,),
            Text(
              "$text",
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// 默认样式的输入框，单行
  ///
  static Widget getDefaultTextField(
    {
      String hintText = "输入钱包名称",
      double fontSize = 16,
      TextEditingController textEditingController,
      int maxLength = 100,
      TextAlign textAlign = TextAlign.start,
    }
      ){
    return Container(
      height: 56,
      color: Colors.white,
      child: new TextField(
        controller: textEditingController,
        style: TextStyle(fontSize: fontSize,color: MyColors.BLACK_TEXT_22),
        textAlign: textAlign,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: MyColors.GRAY_TEXT_99),
          hintText: hintText,
          border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(8.0), // 设置圆角
              borderSide: BorderSide.none // 设置不要边框
          ),
        ),
      ),
    );
  }

}