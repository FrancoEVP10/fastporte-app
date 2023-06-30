import 'package:fastporte_app/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class VehicleAndExperienceScreen extends StatelessWidget {
  final isDialOpen = ValueNotifier(false);
  final activeRole = globals.role == 'transportista' ? true : false;
  VehicleAndExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
                  initialValue: 'Conductor de Turismo en "Turismo Perú"',
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
              buildCardsVehicle(),
              const SizedBox(height: 20),
            ],
          ),
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
  }

  Widget buildCardsVehicle() => Column(
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
              initialValue: 'Marca',
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
              initialValue: 'Categoría',
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
              initialValue: 'Tipo de carro',
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
              initialValue: '15',
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
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaGTkangAvWyBxzH5edVlfI4UH9KSaUude7Q&usqp=CAU',
                  height: 200,
                  width: 230,
                ),
              ),
            ],
          )),
        ],
      );
}
