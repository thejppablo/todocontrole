import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  List<ItemModel> items = List.generate(4, (index) => ItemModel(title: '', image: null));
  // Lista para armazenar as imagens selecionadas
  //List<File?> _imagensSelecionadas = List.generate(4, (_) => null);

  // Função para selecionar uma imagem da galeria
  Future<void> _selecionarImagem(int indice) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        items[indice].image = File(pickedFile.path);
      });
    }
  }

  // Função para adicionar um quadrado vazio
  void _adicionarQuadrado() {
    setState(() {
      items.add(ItemModel(title: '', image: null));
    });
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(onPressed: (){setState(() {
        isCustomizable = !isCustomizable;
      });},),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                child: Icon(Icons.add),
                                onTap: () => _showDialog(indice),
                              ), // Ícone de adição se não houver imagem
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
                        style:
                            IconButton.styleFrom(backgroundColor: Colors.black),
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
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          style:
                              IconButton.styleFrom(backgroundColor: Colors.red),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Botão para adicionar mais quadrados vazios
          ElevatedButton(
            onPressed: _adicionarQuadrado,
            child: Text('Adicionar Quadrado'),
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
            title: Text("nome do quadrado"),
            content: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: 'insira um nome', border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    setState(() {
                      items[index].title = textEditingController.text;
                      textEditingController.clear();
                    });
                    _selecionarImagem(index);
                    Navigator.pop(context, 'OK');
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
