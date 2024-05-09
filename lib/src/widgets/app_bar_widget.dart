import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget{
  const AppBarWidget({super.key, required this.onPressed});

  final Function()? onPressed;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('Exemplo de Seleção de Imagem'),
        actions: [
          ElevatedButton(
            onPressed: widget.onPressed,
            child: Text(
              'Editar',
              style: TextStyle(),
            ),
          )
        ],
      );
  }
  
}