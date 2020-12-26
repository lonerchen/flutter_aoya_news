

class StringFormat{

  static String numberToCn(int i,{bool isWeek = true}){
    switch(i){
      case 0:
        return "零";
      case 1:
        return "一";
      case 2:
        return "二";
      case 3:
        return "三";
      case 4:
        return "四";
      case 5:
        return "五";
      case 6:
        return "六";
      case 7:
        return isWeek ? "天": "七";
      case 8:
        return "八";
      case 9:
        return "九";
      case 10:
        return "十";
      default:
        return "错误";
    }
  }

}