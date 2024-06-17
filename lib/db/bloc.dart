import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../db_event/cat_event_db.dart';
import 'model.dart';

class SavedCatBloc extends Cubit<CatState> {
  final Box<Cat> taskBox;

  SavedCatBloc(this.taskBox) : super(CatInitial()) {
    loadCats();
  }

  void addCat(Cat task) {
    taskBox.add(task);
    emit(CatLoaded(taskBox.values.toList()));
  }

  void removeCat(Cat task) {
    task.delete();
    emit(CatLoaded(taskBox.values.toList()));
  }

  void toggleCatCompletion(Cat task) {
    // task.completed = !task.completed;
    task.save();
    emit(CatLoaded(taskBox.values.toList()));
  }

  void loadCats() {
    emit(CatLoaded(taskBox.values.toList()));
  }
}
