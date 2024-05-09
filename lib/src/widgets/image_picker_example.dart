import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void main(){
  runApp(MaterialApp(
    home: ImagePickerExamplePage(title: 'sdfasdasd'),
  ));
}


class ImagePickerExamplePage extends StatefulWidget {
  const ImagePickerExamplePage({super.key, required this.title});

  final String title;

  @override
  State<ImagePickerExamplePage> createState() => _ImagePickerExamplePageState();
}

class _ImagePickerExamplePageState extends State<ImagePickerExamplePage> {
  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: null,
          icon: Icon(PhosphorIcons.magnifyingGlass()),
          color: Colors.black54,
        ),
        title: Text(
          'Perfil',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(PhosphorIcons.bell()),
            color: Colors.black54,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey[200],
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          onPressed: _showOpcoesBottomSheet,
                          icon: Icon(
                            PhosphorIcons.pencilSimple(),
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    label: Text(
                      'Viagens',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Chip(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.grey[200],
                    label: Text(
                      'Eventos',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey[400],
                          ),
                    ),
                  ),
                  Chip(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.grey[200],
                    label: Text(
                      'Dados',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey[400],
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[200],
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Santiago Valentin',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Uma excelente viagem',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[200],
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('https://picsum.photos/300'),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Florida',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Uma viagem inesquecível',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[200],
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('https://picsum.photos/400'),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Canadá',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'A melhor viagem que já fiz',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.image(),
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.camera(),
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Fazer foto da câmera
                  pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.trash(),
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Tornar a foto null
                  setState(() {
                    imageFile = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}