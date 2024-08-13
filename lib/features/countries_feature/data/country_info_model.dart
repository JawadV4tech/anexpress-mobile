// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class CountryInfoModel extends Equatable {
  final int? id;
  final String? name;

  const CountryInfoModel({
    this.id,
    this.name,
  });

  CountryInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() => 'CountryInfoModel(id: $id, name: $name)';
}
