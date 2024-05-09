import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Seleção de Imagem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaSelecaoImagem(),
    );
  }
}

class PaginaSelecaoImagem extends StatefulWidget {
  @override
  _PaginaSelecaoImagemState createState() => _PaginaSelecaoImagemState();
}

class _PaginaSelecaoImagemState extends State<PaginaSelecaoImagem> {
  // Lista para armazenar as imagens selecionadas
  List<File?> _imagensSelecionadas = List.generate(4, (_) => null);

  // Função para selecionar uma imagem da galeria
  Future<void> _selecionarImagem(int indice) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagensSelecionadas[indice] = File(pickedFile.path);
      });
    }
  }

  // Função para adicionar um quadrado vazio
  void _adicionarQuadrado() {
    setState(() {
      _imagensSelecionadas.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de Seleção de Imagem'),
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
              itemCount: _imagensSelecionadas.length,
              itemBuilder: (context, indice) {
                return InkWell(
                  onTap: () => _selecionarImagem(indice),
                  child: Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: _imagensSelecionadas[indice] != null
                          ? Image.file(_imagensSelecionadas[indice]!)
                          : Icon(Icons.add), // Ícone de adição se não houver imagem
                    ),
                  ),
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
}
