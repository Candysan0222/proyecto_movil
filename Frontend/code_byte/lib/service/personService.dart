import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:code_byte/models/person.dart';

class ApiService {
  final String baseUrl =
      'http://192.168.100.44:9000/proyectoGT/Seguridad'; // Cambia esto a tu URL base

  Future<bool> savePersona(Persona p) async {
    final url =
        Uri.parse('$baseUrl/Personas/'); // Cambia esto a la ruta de tu API

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(p.toJson()), // Convierte el objeto persona a JSON
      );
      print('Cuerpo de la solicitud: ${jsonEncode(p.toJson())}');
      print(url);
      if (response.statusCode == 200) {
        // Si la respuesta es exitosa (201 Created)
        return true; // Guardado exitosamente
      } else {
        // Manejo de errores si la respuesta no es exitosa
        print('Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Manejo de excepciones
      print('Error: $e');
      return false;
    }
  }
}
