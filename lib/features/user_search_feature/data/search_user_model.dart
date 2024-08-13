class SearchUserModel {
  final int? id;
  final String? name;

  SearchUserModel({
    this.id,
    this.name,
  });

  SearchUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
