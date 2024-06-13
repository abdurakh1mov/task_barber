import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cat_event/cat_fact_bloc.dart';

class SavedFactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catFactBloc = BlocProvider.of<CatFactBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Cat Facts'),
      ),
      body: ListView.builder(
        itemCount: catFactBloc.savedFacts.length,
        itemBuilder: (context, index) {
          final item = catFactBloc.savedFacts[index];
          final fact = item.fact;
          final imageUrl = item.imageUrl;
          final createdAt = item.createdAt;
          final bytes = base64Decode(imageUrl);
          return itemSavedFacts(bytes, fact, createdAt);
        },
      ),
    );
  }

  Widget itemSavedFacts(Uint8List bytes, String fact, String createdAt) {
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
                bytes,
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
