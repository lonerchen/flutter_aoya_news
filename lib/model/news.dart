class NewsBean {
  int id;
  int columnId;
  String date;
  String title;
  String link;
  String content;
  int grade;
  String highlightColor;
  int upCounts;
  int downCounts;
  int isShow;
  int resourceId;
  String createdAt;
  String updatedAt;
  List<String> images;

  NewsBean(
      {this.id,
        this.columnId,
        this.date,
        this.title,
        this.link,
        this.content,
        this.grade,
        this.highlightColor,
        this.upCounts,
        this.downCounts,
        this.isShow,
        this.resourceId,
        this.createdAt,
        this.updatedAt,
        this.images});

  static List<NewsBean> formJsonList(dynamic jsonList){
    var list = List<NewsBean>();
    jsonList.forEach((c){
      list.add(NewsBean.fromJson(c));
    });
    return list;
  }

  NewsBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    columnId = json['column_id'];
    date = json['date'];
    title = json['title'];
    link = json['link'];
    content = json['content'];
    grade = json['grade'];
    highlightColor = json['highlight_color'];
    upCounts = json['up_counts'];
    downCounts = json['down_counts'];
    isShow = json['is_show'];
    resourceId = json['resource_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
//    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['column_id'] = this.columnId;
    data['date'] = this.date;
    data['title'] = this.title;
    data['link'] = this.link;
    data['content'] = this.content;
    data['grade'] = this.grade;
    data['highlight_color'] = this.highlightColor;
    data['up_counts'] = this.upCounts;
    data['down_counts'] = this.downCounts;
    data['is_show'] = this.isShow;
    data['resource_id'] = this.resourceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['images'] = this.images;
    return data;
  }
}
