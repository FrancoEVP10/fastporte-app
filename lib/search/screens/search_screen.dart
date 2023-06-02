import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Variables for storing selected filter values
  String selectedTipoServicio = 'carga';
  String selectedTamanoVehiculo = 'grande';
  String selectedDocumentacion = 'si';

  // List of example results
  List<Map<String, dynamic>> results = [
    {
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png',
      'nombre': 'Vehículo 1',
      'calificacion': 4.5,
      'descripcion': 'Descripción del vehículo 1',
    },
    {
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png',
      'nombre': 'Vehículo 2',
      'calificacion': 3.8,
      'descripcion': 'Descripción del vehículo 2',
    },
    // Add more example elements here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Vehicle'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Filtros de búsqueda',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Tipo de Servicio'),
              subtitle: Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedTipoServicio,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTipoServicio = newValue!;
                    });
                  },
                  items: <String>['carga', 'mudanza']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Tamaño de Vehículo'),
              subtitle: Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedTamanoVehiculo,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTamanoVehiculo = newValue!;
                    });
                  },
                  items: <String>['grande', 'pequeño']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Documentación Completa'),
              subtitle: Container(
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedDocumentacion,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDocumentacion = newValue!;
                    });
                  },
                  items: <String>['si', 'no']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Logic to perform search based on selected filters
                  // You can use the values of selectedTipoServicio,
                  // selectedTamanoVehiculo, and selectedDocumentacion to filter the list
                  // of results and display only the desired items.
                },
                child: const Text(
                  'Buscar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return ListTile(
                  leading: Image.network(result['image']),
                  title: Text(result['nombre']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Calificación: ${result['calificacion']}'),
                      Text('Descripción: ${result['descripcion']}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
