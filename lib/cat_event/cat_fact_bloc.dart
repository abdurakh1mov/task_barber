import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_barber/cat_event/model.dart';
import 'package:task_barber/service/api_service.dart';
import 'package:task_barber/service/image/service.dart';
import '../db/model.dart';
import 'cat_fact_event.dart';
import 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  final ApiService apiService;
  final ImageService imageService;
  final Random _random = Random();
  List<CatSavedModel> savedFacts = [];

  CatFactBloc()
      : apiService =
            ApiService(Dio(BaseOptions(contentType: 'application/json'))),
        imageService =
            ImageService(Dio(BaseOptions(contentType: 'application/json'))),
        super(CatFactInitial()) {
    on<FetchCatFact>(_onFetchCatFact);
  }

  void _onFetchCatFact(FetchCatFact event, Emitter<CatFactState> emit) async {
    emit(CatFactLoading());

    try {
      final List<CatFactModel> facts = await apiService.getCats();
      final randomNum = _random.nextInt(facts.length);
      final fact = facts[randomNum].text;
      final createdAt = facts[randomNum].createdAt;
      DateTime dateTime = DateTime.parse(createdAt);
      String formattedDate = DateFormat('dd:MM:yyyy').format(dateTime);
      final imageResponse = await imageService.getCatImage();
      var base64image = base64Encode(imageResponse.data);
      savedFacts.add(CatSavedModel(
        fact: fact,
        image: base64image,
        createdAt: formattedDate,
      ));

      emit(CatFactLoaded(
          fact: fact, imageUrl: base64image, createdAt: formattedDate));
    } catch (e) {
      emit(CatFactError(message: e.toString()));
    }
  }
}
