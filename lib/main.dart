import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_barber/db/bloc.dart';
import 'package:task_barber/screen/main_screen.dart';
import 'package:task_barber/screen/saved_facts_screen.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'cat_event/cat_fact_bloc.dart';
import 'db/adapter.dart';
import 'db/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CatAdapter());
  }
  // Hive.registerAdapter(CatAdapter());
  // await clearHiveData();
  // if (!await Hive.boxExists('cats')) {
  // if()
  await Hive.openBox<Cat>('cats');
  // }
  runApp(const CatFactApp());
}

Future<void> clearHiveData() async {
  await Hive.deleteBoxFromDisk('cats');
}

class CatFactApp extends StatelessWidget {
  const CatFactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SavedCatBloc>(
          create: (context) => SavedCatBloc(
            Hive.box<Cat>('cats'),
          ),
        ),
        BlocProvider<CatFactBloc>(
          create: (context) => CatFactBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cat Fact App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
        routes: {
          '/savedFacts': (context) => SavedFactsPage(),
        },
      ),
    );
  }
}
