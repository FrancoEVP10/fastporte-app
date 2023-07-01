import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../vehicle/model/vehicle.dart';
import '../../vehicle/service/vehicle_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final vehicleService = VehicleService();

  // Variables for storing selected filter values
  String selectedTipoServicio = 'carga';
  int selectedQuantity = 1;
  String selectedDocumentacion = 'si';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Buscar Transportista',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            _buildTipoServicioDropdown(),
            _buildQuantityInput(),
            // _buildDocumentacionDropdown(),
            // _buildSearchButton(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: vehicleService.getVehicleByCategoryAndQuantity(
                      selectedTipoServicio, selectedQuantity),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final vehicles = snapshot.data as List<Vehicle>;
                      if (vehicles.isEmpty) {
                        return const Center(
                          child: Text('No se encontraron vehículos'),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vehicles.length,
                          itemBuilder: (context, index) {
                            final vehicle = vehicles[index];
                            final driver = vehicle.driver;
                            return GestureDetector(
                              onTap: () => {
                                print('Vehicle selected: ${vehicle.id}'),
                                Navigator.pushNamed(context, 'create-contract', arguments: { 'vehicle': vehicle })
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                          child: _buildDriverImage(driver.photo)),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Text(
                                                  "${driver.name} ${driver.lastname}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                  )
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Text(
                                                  driver.description, 
                                                  textAlign: TextAlign.justify
                                                ),
                                              ),
                                              Text('Vehicle brand: ${vehicle.brand}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              )
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDriverImage(photoUrl) {
    if (photoUrl.isEmpty) {
      return Image.asset("assets/imgs/user-vector.png",
          width: 100, height: 100);
    } else {
      return Image.network(photoUrl, width: 100, height: 100);
    }
  }

  Widget _buildTipoServicioDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormField<String>(builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Tipo de Servicio',
            hintText: 'Seleccione el tipo de servicio',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedTipoServicio,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTipoServicio = newValue!;
                });
              },
              items: <String>['carga', 'mudanza', 'transporte']
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
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuantityInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: selectedQuantity.toString(),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          labelText: (selectedTipoServicio == 'transporte')
              ? 'Cantidad de pasajeros'
              : 'Peso de la carga',
          hintText: (selectedTipoServicio == 'transporte')
              ? 'Cantidad de pasajeros'
              : 'Peso de la carga',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          setState(() {
            selectedQuantity = int.parse(value);
          });
        },
      ),
    );
  }

  Widget _buildDocumentacionDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormField<String>(builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Documentación completa',
            hintText: 'Seleccione si desea documentación completa',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedDocumentacion,
              isDense: true,
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
            ),
          ),
        );
      }),
    );
  }
}

Widget _buildSearchButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Color.fromRGBO(15, 21, 163, 1)),
        child: Text('Buscar')),
  );
}
