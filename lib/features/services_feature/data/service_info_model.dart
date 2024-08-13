import 'package:equatable/equatable.dart';

class ServiceInfoModel extends Equatable {
  final int? id;
  final String? name;

  const ServiceInfoModel({
    this.id,
    this.name,
  });

  ServiceInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
