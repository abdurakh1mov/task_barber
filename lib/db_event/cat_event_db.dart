import 'package:equatable/equatable.dart';

import '../db/model.dart';

abstract class CatState extends Equatable {
  const CatState();

  @override
  List<Object> get props => [];
}

class CatInitial extends CatState {}

class CatLoaded extends CatState {
  final List<Cat> tasks;

  const CatLoaded(this.tasks);

  @override
  List<Cat> get props => tasks;
}
