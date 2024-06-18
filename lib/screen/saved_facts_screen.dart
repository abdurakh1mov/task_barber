import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../db/bloc.dart';
import '../db_event/cat_event_db.dart';

class SavedFactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedCatBloc = BlocProvider.of<SavedCatBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Cat Facts'),
        ),
        body: BlocBuilder<SavedCatBloc, CatState>(
          builder: (context, state) {
            if (state is CatInitial) {
              savedCatBloc.loadCats();
              return const Center(child: CircularProgressIndicator());
            } else if (state is CatLoaded) {
              final cats = state.tasks;
              return ListView.builder(
                itemCount: cats.length,
                itemBuilder: (context, index) {
                  final item = cats[index];
                  final fact = item;
                  final imageUrl = item.createdAt;
                  final createdAt = item.image;
                  print(createdAt);
                  final bytes = base64Decode(createdAt);
                  return itemSavedFacts(bytes, fact.fact, imageUrl);
                },
              );
            } else {
              return const Center(child: Text('Error loading cats.'));
            }
          },
        ));
  }

  Widget itemSavedFacts(Uint8List image, String fact, String createdAt) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.memory(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Container(
                height: 100,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          fact,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        'Created at: $createdAt',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
