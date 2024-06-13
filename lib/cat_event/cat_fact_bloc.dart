import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:task_barber/model/cat_model.dart';
import 'cat_fact_event.dart';
import 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  final String factUrl = 'https://cat-fact.herokuapp.com/facts';
  final String imageUrl = 'https://cataas.com/cat';

  List<CatModel> savedFacts = [];
  final Random _random = Random();

  CatFactBloc() : super(CatFactInitial()) {
    on<FetchCatFact>(_onFetchCatFact);
  }

  void _onFetchCatFact(FetchCatFact event, Emitter<CatFactState> emit) async {
    emit(CatFactLoading());
    try {
      final factResponse = await http.get(Uri.parse(factUrl));
      final factJson = jsonDecode(factResponse.body);
      final randomNum = _random.nextInt(factJson.length - 1) + 1;
      final fact = factJson[randomNum]['text'];
      final createdAt = factJson[randomNum]['createdAt'];
      DateTime dateTime = DateTime.parse(createdAt);
      String formattedDate = DateFormat('dd:MM:yyyy').format(dateTime);

      final imageResponse = await http.get(Uri.parse(imageUrl));
      final base64Image = base64Encode(imageResponse.bodyBytes);

      savedFacts.add(CatModel(
        fact: fact,
        imageUrl: base64Image,
        createdAt: formattedDate,
      ));

      emit(CatFactLoaded(
          fact: fact, imageUrl: base64Image, createdAt: formattedDate));
    } catch (e) {
      emit(CatFactError(message: e.toString()));
    }
  }
}
