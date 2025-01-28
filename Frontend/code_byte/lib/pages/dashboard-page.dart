import 'package:flutter/material.dart';
import 'package:code_byte/main.dart';
import 'package:code_byte/models/TravelPackage.dart';
import 'package:code_byte/service/TravelPackageService.dart';
import 'package:code_byte/pages/us-page.dart';
import 'package:code_byte/pages/offers-page.dart';
import 'package:code_byte/pages/travel-page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<TravelPackage>> travelPackages;

  @override
  void initState() {
    super.initState();
    final service = TravelPackageService(
        'http://192.168.100.44:9000/proyectoGT'); // Cambia a tu URL
    travelPackages = service.fetchTravelPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Golden Travel'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 145, 8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/imagologoblack.png', // Coloca tu logo aquí
                    width: 200,
                    height: 100,
                  ),
                ],
              ),
            ),
            // Menú de navegación
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Nosotros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NosotrosPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Viajes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViajesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text('Ofertas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OfertasPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Salir'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<TravelPackage>>(
        future: travelPackages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay paquetes de viaje disponibles.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  'Tus tickets',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Tarjetas de los tickets
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _buildTicketCard(context, snapshot.data![index]);
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Botón para agregar un nuevo viaje
                ElevatedButton.icon(
                  onPressed: () {
                    // Lógica para añadir un nuevo viaje
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                  label: Text('Agregar nuevo viaje',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 243, 159, 33),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget que crea la tarjeta del ticket
  Widget _buildTicketCard(BuildContext context, TravelPackage travelPackage) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.directions_bus_filled_outlined,
            size: 40, color: Color.fromARGB(255, 243, 159, 33)),
        title: Text('Paquete: ${travelPackage.description}'),
        subtitle: Text(
            'Fecha de salida: ${travelPackage.departureDate.toString()}'), // Asegúrate de formatear la fecha
        trailing: Icon(Icons.arrow_forward),
        // onTap: () {
        //   // Navegar a la página de detalles del ticket
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => TicketDetailPage(
        //         destino: travelPackage
        //             .touristSite.name, // Asegúrate de que esto esté correcto
        //         numeroTicket: travelPackage.id
        //             .toString(), // O cualquier otro identificador
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }
}
