import '../db/model.dart';

abstract class CatFactState {}

class CatFactInitial extends CatFactState {}

class CatFactLoading extends CatFactState {}

class CatFactLoaded extends CatFactState {
  final String fact;
  final String imageUrl;
  final String createdAt;

  CatFactLoaded(
      {required this.fact, required this.imageUrl, required this.createdAt});
}

class CatFactError extends CatFactState {
  final String message;

  CatFactError({required this.message});
}

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final List<CatSavedModel> cat;

  CatLoaded(this.cat);
}

class CatError extends CatState {
  final String message;

  CatError(this.message);
}
