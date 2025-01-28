import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl =
      'http://192.168.100.44:9000/proyectoGT/Seguridad/Usuarios'; // Cambia esto según tu URL base

  Future<void> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(
          '$_baseUrl/GuardarUsuarioJwt'), // Endpoint para guardar el usuario
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      // Manejo de éxito (puedes agregar lógica adicional aquí si lo necesitas)
      print('Usuario registrado con éxito: ${response.body}');
    } else {
      // Manejo de error
      throw Exception('Error al registrar el usuario: ${response.body}');
    }
  }
}
