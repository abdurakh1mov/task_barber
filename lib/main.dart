import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_barber/screen/main_screen.dart';
import 'package:task_barber/screen/saved_facts_screen.dart';

import 'cat_event/cat_fact_bloc.dart';

void main() {
  runApp(CatFactApp());
}

class CatFactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatFactBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cat Fact App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
        routes: {
          '/savedFacts': (context) => SavedFactsPage(),
        },
      ),
    );
  }
}
