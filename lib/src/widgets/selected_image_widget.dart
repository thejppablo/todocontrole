import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SelectedImageWidget extends StatefulWidget {
  const SelectedImageWidget({super.key, required this.file, required this.text});

  final File file;
  final String text;

  @override
  State<SelectedImageWidget> createState() => _SelectedImageWidgetState();
}

class _SelectedImageWidgetState extends State<SelectedImageWidget> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();

  Future<void> speak() async{
    await flutterTts.setLanguage('pt-BR');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.file(widget.file),
      onTap: () {
        speak();
      },
    );
  }

}