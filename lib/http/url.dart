


class URL{

  static const String BASE_URL = "https://zxcvbnm-asdfghjkl.aoya.news/";

  ///
  /// banner 首页广告图
  ///
  static String homeBanner = "/api/banner";

  ///
  /// news 24小时快讯
  /// params day = 今天日期
  ///
  static String  news24H = "/api/news";

  ///
  /// column 首页Tab栏
  /// params id = 1//默认id等于1
  ///
  static String homeTab = "/api/column";

  ///
  /// lists 首页tab栏对应的广告
  /// param page = 1 分页下标
  /// param size = 12 单页数量
  /// param column_id = tab的id
  ///
  static String homeTabContent = "/api/lists";

  ///
  /// market 币的价格跟种类，涨跌幅
  ///
  static String coinList = "/api/market";

  ///
  /// 新闻详情
  ///
  static String newsDetails = "/api/details";

  ///
  /// 快讯利好利空
  ///
  static String newsBear = "/api/flash-bear";

  ///
  /// 快讯新闻详情
  ///
  static String topicDetails = "/api/news-details";

  ///
  /// 热门
  ///
  static String hotNews = "/api/hot";

  ///
  /// 搜索
  ///
  static String search = "/api/search";

}