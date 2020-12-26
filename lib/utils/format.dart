class FormatUtils{

  ///
  /// position 保留的小数位数
  /// 保留小数 万位以后用单位替换
  ///
  static String formatNumW(num num,{int position = 2}){
    String unit = "";
    if(num >= 10000 && num < 100000000){
      num = num / 10000;
      unit = "万";
    }else if(num >= 100000000){
      num = num / 100000000;
      unit = "亿";
    }
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<position){
      //小数点后有几位小数
      return ( num.toStringAsFixed(position).substring(0,num.toString().lastIndexOf(".")+position+1).toString()) + unit;
    }else{
      return ( num.toString().substring(0,num.toString().lastIndexOf(".")+position+1).toString()) + unit;
    }
  }

}