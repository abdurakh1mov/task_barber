import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class CatSavedModel extends HiveObject {
  @HiveField(0)
  final String fact;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String image;

  CatSavedModel({
    required this.fact,
    required this.createdAt,
    required this.image,
  });
}
