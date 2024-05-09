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
  // Variável de controle para alternar entre o modo de edição e visualização
  bool isCustomizable = false;

  // Lista para armazenar os quadrados, cada um representado por um ItemModel
  List<ItemModel> items =
      List.generate(4, (index) => ItemModel(title: '', image: null));

  // Função para selecionar uma imagem da galeria
  Future<void> _selecionarImagem(int indice) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Atualiza a imagem do quadrado correspondente na lista de items
        items[indice].image = File(pickedFile.path);
      });
    }
  }

  // Função para adicionar um quadrado vazio
  void _adicionarQuadrado() {
    setState(() {
      // Adiciona um novo ItemModel à lista de items
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
      appBar: AppBarWidget(
        // Botão na AppBar para alternar entre o modo de edição e visualização
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
                                // Exibe a imagem do quadrado se estiver presente
                                file: items[indice].image!,
                                text: items[indice].title,
                              )
                            : InkWell(
                                // Ícone de adição se não houver imagem
                                child: Icon(Icons.add),
                                onTap: () => _showDialog(indice),
                              ),
                      ),
                    ),
                    Visibility(
                      // Botão de edição (lápis) visível apenas no modo de edição
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
                      // Botão de exclusão (X) visível apenas no modo de edição
                      visible: isCustomizable,
                      child: Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              // Remove o quadrado da lista de items
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

  // Função para exibir um diálogo para inserir um título personalizado
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
                      // Atualiza o título do quadrado correspondente na lista de items
                      items[index].title = textEditingController.text;
                      textEditingController.clear();
                    });
                    // Seleciona uma imagem após inserir o título
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
