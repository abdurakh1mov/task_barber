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
