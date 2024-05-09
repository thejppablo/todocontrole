import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todocontrole/src/widgets/selected_image_widget.dart';


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
  
  final TextEditingController textEditingController = TextEditingController();
  late List<String> squareNames;

  @override
  void initState(){
    super.initState();
        squareNames = List<String>.generate(_imagensSelecionadas.length, (index) => "$index");
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
                return Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: _imagensSelecionadas[indice] != null
                        ? SelectedImageWidget(file: _imagensSelecionadas[indice]!, text: squareNames[indice],)
                        : InkWell(child: Icon(Icons.add), onTap: () => _showDialog(indice), ), // Ícone de adição se não houver imagem
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

  Future<void> _showDialog(int index) async {
    return showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
      return AlertDialog(
        title: Text("nome do quadrado"),
        
        content: TextField(controller: textEditingController,
        
        decoration: InputDecoration(hintText: 'insira um nome', border: OutlineInputBorder()),
        ),
        actions: [TextButton(
              onPressed: (){
                if(textEditingController.text.isNotEmpty){
                  setState(() {
                    squareNames[index] = textEditingController.text;
                    print(squareNames);
                  });
                    _selecionarImagem(index);
                    Navigator.pop(context, 'OK');
                }
              },
              child: const Text('OK'),
            ),],
      );
    });
  }

}
