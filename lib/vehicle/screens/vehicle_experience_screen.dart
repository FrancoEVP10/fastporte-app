import 'package:fastporte_app/vehicle/model/vehicle.dart';
import 'package:fastporte_app/vehicle/service/vehicle_service.dart';
import 'package:fastporte_app/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class VehicleAndExperienceScreen extends StatelessWidget {
  final isDialOpen = ValueNotifier(false);
  final activeRole = globals.role == 'transportista' ? true : false;
  VehicleAndExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleService = Provider.of<VehicleService>(context);
    final vehicleFuture = vehicleService.getVehicleByDriverId(globals.localId);

    return FutureBuilder(
        future: vehicleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final vehicle = snapshot.data;
            return Scaffold(
              body: ListView(
                children: [
                  if (snapshot.hasData)
                    Column(
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              'Experiencia Laboral',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Trabajo',
                            ),
                            initialValue:
                                'Conductor de Turismo en "Turismo Perú"',
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Acerca del vehículo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildCardsVehicle(vehicle),
                        const SizedBox(height: 20),
                      ],
                    ),
                  if (!snapshot.hasData)
                    Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 300),
                          Text(
                            'Usted no posee información.',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    )
                ],
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: SpeedDial(
                  visible: activeRole,
                  animatedIcon: AnimatedIcons.menu_close,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.4,
                  spaceBetweenChildren: 12,
                  children: [
                    SpeedDialChild(
                        child: Icon(Icons.fire_truck_sharp),
                        backgroundColor: Color.fromRGBO(26, 204, 141, 1),
                        label: 'Editar Vehículo'),
                    SpeedDialChild(
                        child: Icon(Icons.star),
                        backgroundColor: Color.fromRGBO(26, 204, 141, 1),
                        label: 'Experiencia')
                  ],
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget buildCardsVehicle(Vehicle vehicle) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Marca',
              ),
              initialValue: vehicle.brand,
              readOnly: true,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Categoría',
              ),
              initialValue: vehicle.category,
              readOnly: true,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Tipo de carro',
              ),
              initialValue: vehicle.typeCar,
              readOnly: true,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Capacidad de personas',
              ),
              initialValue: vehicle.quantity.toString(),
              readOnly: true,
            ),
          ),
          const SizedBox(height: 20),
          CardContainer(
              child: Column(
            children: [
              Center(
                child: Text(
                  'Foto del vehículo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                height: 100,
                child: Image.network(
                  vehicle.photoCar,
                  height: 200,
                  width: 230,
                ),
              ),
            ],
          )),
        ],
      );
}
