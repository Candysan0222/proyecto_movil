import 'dart:convert';
import 'package:code_byte/models/login.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl =
      'http://192.168.100.44:9000/proyectoGT/jwt/auth/login'; // Cambia por la URL de tu API

  Future<login?> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return login.fromJson(jsonResponse);
      } else {
        print('Error al iniciar sesión: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}
