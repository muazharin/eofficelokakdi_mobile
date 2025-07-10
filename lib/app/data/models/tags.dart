class TagsModel {
  int? id;
  String? name;
  void Function()? onTap;

  TagsModel({this.id, this.name, this.onTap});

  factory TagsModel.fromJson(Map<String, dynamic> json) =>
      TagsModel(id: json["id"], name: json["name"], onTap: json["onTap"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "onTap": onTap};
}
