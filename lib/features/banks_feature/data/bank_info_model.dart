import 'package:equatable/equatable.dart';

class BankInfoModel extends Equatable {
  final int? id;
  final String? name;

  const BankInfoModel({
    this.id,
    this.name,
  });

  BankInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
