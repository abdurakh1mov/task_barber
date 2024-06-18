import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_barber/db/bloc.dart';
import '../cat_event/cat_fact_bloc.dart';
import '../cat_event/cat_fact_event.dart';
import '../cat_event/cat_fact_state.dart';
import '../db/model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainScreen> {
  late CatFactBloc _catFactBloc;

  @override
  void initState() {
    super.initState();
    _catFactBloc = BlocProvider.of<CatFactBloc>(context);
    _catFactBloc.add(FetchCatFact());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Fact App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/savedFacts');
            },
          ),
        ],
      ),
      body: BlocBuilder<CatFactBloc, CatFactState>(
        builder: (context, state) {
          if (state is CatFactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatFactLoaded) {
            try {
              final newTask = CatSavedModel(
                fact: state.fact,
                createdAt: state.createdAt,
                image: state.imageUrl,
              );
              context.read<SavedCatBloc>().addCat(newTask);
              final bytes = base64Decode(state.imageUrl);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        Text(state.fact, style: const TextStyle(fontSize: 24)),
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          'Created at: ${state.createdAt}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _catFactBloc.add(FetchCatFact());
                      },
                      child: const Text('Another Fact'),
                    ),
                  ),
                ],
              );
            } catch (e) {
              return Center(
                  child: Text('Error decoding image: ${e.toString()}'));
            }
          } else if (state is CatFactError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Welcome to Cat Fact App!'));
          }
        },
      ),
    );
  }
}
