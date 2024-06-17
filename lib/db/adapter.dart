import 'package:hive/hive.dart';

import 'model.dart';

class CatAdapter extends TypeAdapter<Cat> {
  @override
  final typeId = 1;

  @override
  Cat read(BinaryReader reader) {
    final fact = reader.readString();
    final image = reader.readString();
    final createdAt = reader.readString();
    return Cat(
      fact: fact.toString(),
      image: image.toString(),
      createdAt: createdAt.toString(),
    );
  }

  @override
  void write(BinaryWriter writer, Cat cat) {
    writer.writeString(cat.fact);
    writer.writeString(cat.image);
    writer.writeString(cat.createdAt);
  }
}
