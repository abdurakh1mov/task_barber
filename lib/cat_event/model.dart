import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class CatFactModel {
  @JsonKey(name: '_id')
  final String id;
  final String? user;
  final String text;
  final String? source;
  final bool? deleted;
  final bool? used;
  final String createdAt;
  final String updatedAt;

  CatFactModel({
    required this.id,
    this.user,
    required this.text,
    this.source,
    this.deleted,
    this.used,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CatFactModel.fromJson(Map<String, dynamic> json) =>
      _$CatFactModelFromJson(json);
  Map<String, dynamic> toJson() => _$CatFactModelToJson(this);
}
