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
      'image': 'url_imagen_1',
      'nombre': 'Vehículo 1',
      'calificacion': 4.5,
      'descripcion': 'Descripción del vehículo 1',
    },
    {
      'image': 'url_imagen_2',
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
      body: Column(
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
            subtitle: DropdownButton<String>(
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
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Tamaño de Vehículo'),
            subtitle: DropdownButton<String>(
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
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Documentación Completa'),
            subtitle: DropdownButton<String>(
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
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Logic to perform search based on selected filters
              // You can use the values of selectedTipoServicio,
              // selectedTamanoVehiculo, and selectedDocumentacion to filter the list
              // of results and display only the desired items.
            },
            child: const Text('Buscar'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
