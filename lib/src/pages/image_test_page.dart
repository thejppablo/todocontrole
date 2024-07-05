import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todocontrole/src/models/models.dart';
import 'package:todocontrole/src/widgets/app_bar_widget.dart';
import 'package:todocontrole/src/widgets/selected_image_widget.dart';

class PaginaSelecaoImagem extends StatefulWidget {
  const PaginaSelecaoImagem({super.key});

  @override
  State<PaginaSelecaoImagem> createState() => _PaginaSelecaoImagemState();
}

class _PaginaSelecaoImagemState extends State<PaginaSelecaoImagem> {
  bool isCustomizable = false;
  List<ItemModel> items = [];

  @override
  void initState() {
    super.initState();
    // Carrega os dados salvos ao iniciar a tela
    _loadItems();
  }

  // Carrega os itens salvos do SharedPreferences
  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? itemsJson = prefs.getStringList('items');

    if (itemsJson != null) {
      setState(() {
        items = itemsJson.map((itemJson) => ItemModel.fromJson(itemJson)).toList();
      });
    }
  }

  // Salva os itens no SharedPreferences
  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> itemsJson = items.map((item) => item.toJson()).toList();
    await prefs.setStringList('items', itemsJson);
  }

  Future<void> _selecionarImagem(int indice) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        items[indice].image = File(pickedFile.path);
        _saveItems(); // Salva após a alteração
      });
    }
  }

  void _adicionarQuadrado() {
    setState(() {
      items.add(ItemModel(image: null, title: ''));
      _saveItems(); // Salva após a alteração
    });
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        onPressed: () {
          setState(() {
            isCustomizable = !isCustomizable;
          });
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, indice) {
                return Stack(
                  children: [
                    Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: items[indice].image != null
                            ? SelectedImageWidget(
                                file: items[indice].image!,
                                text: items[indice].title,
                              )
                            : InkWell(
                                child: const Icon(Icons.add),
                                onTap: () => _showDialog(indice),
                              ),
                      ),
                    ),
                    Visibility(
                      visible: isCustomizable,
                      child: IconButton(
                        onPressed: () {
                          _showDialog(indice);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        style: IconButton.styleFrom(backgroundColor: Colors.black),
                      ),
                    ),
                    Visibility(
                      visible: isCustomizable,
                      child: Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              items.removeAt(indice);
                              _saveItems(); // Salva após a alteração
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          style: IconButton.styleFrom(backgroundColor: Colors.red),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _adicionarQuadrado,
            child: const Text('Adicionar Quadrado'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog(int index) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nome do Quadrado"),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Insira um nome',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  setState(() {
                    items[index].title = textEditingController.text;
                    textEditingController.clear();
                    _saveItems(); // Salva após a alteração
                  });
                  _selecionarImagem(index); // Seleciona uma imagem após inserir o título
                  Navigator.pop(context, 'OK');
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
