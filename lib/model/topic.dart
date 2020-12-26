class Topic {
  int id;
  String title;
  String link;
  int type;
  String summary;
  String image;
  int order;
  int parentId;
  int status;
  String createdAt;
  String updatedAt;

  Topic(
      {this.id,
        this.title,
        this.link,
        this.type,
        this.summary,
        this.image,
        this.order,
        this.parentId,
        this.status,
        this.createdAt,
        this.updatedAt});

  static List<Topic> formJsonList(dynamic jsonList){
    var list = List<Topic>();
    jsonList.forEach((c){
      list.add(Topic.fromJson(c));
    });
    return list;
  }

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    type = json['type'];
    summary = json['summary'];
    image = json['image'];
    order = json['order'];
    parentId = json['parent_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['type'] = this.type;
    data['summary'] = this.summary;
    data['image'] = this.image;
    data['order'] = this.order;
    data['parent_id'] = this.parentId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
