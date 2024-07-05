import 'dart:convert';
import 'dart:io';

class ItemModel {
  File? image;
  String title;

  ItemModel({this.image, required this.title});

  // Método para converter ItemModel em um mapa que pode ser armazenado no SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'image': image?.path, // Salva apenas o caminho da imagem para simplificar
      'title': title,
    };
  }

  // Método para criar um ItemModel a partir de um mapa obtido do SharedPreferences
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      image: map['image'] != null ? File(map['image']) : null,
      title: map['title'],
    );
  }

  // Método para converter ItemModel em uma string JSON
  String toJson() => json.encode(toMap());

  // Método para criar um ItemModel a partir de uma string JSON
  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));
}
