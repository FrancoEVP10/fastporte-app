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
      'nombre': 'Oscar Canellas',
      'calificacion': 5,
      'descripcion':
          'Hello. My name is Mario Gomez and I have a car that I use to give tourism service. I have too much experience because...',
    },
    {
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png',
      'nombre': 'Oscar Canellas',
      'calificacion': 5,
      'descripcion':
          'Hello. My name is Mario Gomez and I have a car that I use to give tourism service. I have too much experience because...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Buscar Transportista',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                title: const Text('Tipo de Servicio'),
                subtitle: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                title: const Text('Tamaño de Vehículo'),
                subtitle: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                title: const Text('Documentación Completa'),
                subtitle: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 150,
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
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.5, // Ajusta el factor según el ancho deseado
                child: Container(
                  margin: EdgeInsets.only(bottom: 16, top: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic to perform search based on selected filters
                      // You can use the values of selectedTipoServicio,
                      // selectedTamanoVehiculo, and selectedDocumentacion to filter the list
                      // of results and display only the desired items.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 42, 11, 165),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Image.network(result['image']),
                          title: Text(result['nombre']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                    'Calificación: ${result['calificacion']}'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                    'Descripción: ${result['descripcion']}'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
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
