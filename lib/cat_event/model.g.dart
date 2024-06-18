// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatFactModel _$CatFactModelFromJson(Map<String, dynamic> json) => CatFactModel(
      id: json['_id'] as String,
      user: json['user'] as String?,
      text: json['text'] as String,
      source: json['source'] as String?,
      deleted: json['deleted'] as bool?,
      used: json['used'] as bool?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CatFactModelToJson(CatFactModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'text': instance.text,
      'source': instance.source,
      'deleted': instance.deleted,
      'used': instance.used,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
