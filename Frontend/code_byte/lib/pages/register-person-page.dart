/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:code_byte/models/person.dart';
import 'package:code_byte/pages/register-page.dart';

class PersonInfo extends StatefulWidget {
  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  // Controladores para los campos de texto
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _documentNumberController = TextEditingController();
  TextEditingController _emailController =
      TextEditingController(); // Controlador para el correo electrónico

  String? _selectedDocumentType;
  final List<String> _documentTypes = ['CC', 'CE', 'PP', 'DNI'];

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Advertencia'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _validateNameInput(String value) {
    if (value.isNotEmpty && RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚñÑ ]').hasMatch(value)) {
      _showAlert('El nombre solo puede contener letras y espacios.');
      _nameController.clear();
    }
  }

  void _validateLastNameInput(String value) {
    if (value.isNotEmpty && RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚñÑ ]').hasMatch(value)) {
      _showAlert('El apellido solo puede contener letras y espacios.');
      _lastNameController.clear();
    }
  }

  void _validateDocumentNumberInput(String value) {
    if (value.isNotEmpty && RegExp(r'[^0-9]').hasMatch(value)) {
      _showAlert('El número de documento solo puede contener números.');
      _documentNumberController.clear();
    }
  }

  void _validateEmailInput(String value) {
    // Expresión regular que permite solo letras, números, arroba y puntos
    if (value.isNotEmpty && RegExp(r'[^a-zA-Z0-9@.]').hasMatch(value)) {
      _showAlert(
          'Solo se permiten letras, números, arroba y puntos en el correo electrónico.');
      _emailController
          .clear(); // Limpiar el campo si hay caracteres no permitidos
    }
  }

  Future<void> _submitForm() async {
    if (_nameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _documentNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _selectedDocumentType == null) {
      _showAlert('Por favor, completa todos los campos requeridos.');
      return;
    }

    // Crea el objeto persona con los datos ingresados
    Persona newPerson = Persona(
      names: _nameController.text,
      lastName: _lastNameController.text,
      documentType: _selectedDocumentType,
      document: _documentNumberController.text,
      email: _emailController.text,
    );

    // Navegar al formulario de usuario y pasar la información de persona
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(persona: newPerson),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 250,
                    ),
                  ),
                  Text(
                    'Información del Usuario',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _validateNameInput,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Apellido',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _validateLastNameInput,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Tipo de Documento',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _selectedDocumentType,
                    items: _documentTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDocumentType = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _documentNumberController,
                    decoration: InputDecoration(
                      labelText: 'Número de Documento',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _validateDocumentNumberInput,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _validateEmailInput,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[a-zA-Z0-9@._]')), 
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Continuar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
