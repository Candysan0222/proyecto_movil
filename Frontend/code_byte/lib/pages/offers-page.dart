import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OfertasPage extends StatefulWidget {
  @override
  _OfertasPageState createState() => _OfertasPageState();
}

class _OfertasPageState extends State<OfertasPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context) ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ofertas'),
        ),
        body: Center(
          child: Text(
            'Esta es la página de Ofertas.',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // Evita que el diálogo se cierre al tocar fuera
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Deseas salir de la aplicación?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Cerrar la aplicación
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
