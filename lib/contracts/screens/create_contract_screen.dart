import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fastporte_app/contracts/providers/create_contract_provider.dart';
import 'package:fastporte_app/vehicle/model/vehicle.dart';

class CreateContractScreen extends StatelessWidget {
  const CreateContractScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateContractProvider(),
      child: Consumer<CreateContractProvider>(
        builder: (context, createContractForm, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Crear Contrato'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _CreateContractForm()
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CreateContractForm extends StatefulWidget {
  @override
  State<_CreateContractForm> createState() => _CreateContractFormState();
}

class _CreateContractFormState extends State<_CreateContractForm> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeArrivalController = TextEditingController();
  TextEditingController timeDepartureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final createContractForm = Provider.of<CreateContractProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final vehicle = args['vehicle'] as Vehicle;
    final driver = vehicle.driver;

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateFormat timeFormat = DateFormat('dd/MM/yyyy hh:mm:ss');

    return Form(
      key: createContractForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Datos del vehículo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  // Vehicle attribute widgets
                  _vehicleAttributeBuilder('Vehículo: ', vehicle.id.toString()),
                  _vehicleAttributeBuilder('Conductor: ', driver.name),
                  _vehicleAttributeBuilder('Tipo de Servicio: ', vehicle.category),
                  _vehicleAttributeBuilder('Cantidad carga o personas: ', vehicle.quantity.toString()),
                  _vehicleAttributeBuilder('Tipo de vehículo: ', vehicle.typeCar),
                  _vehicleAttributeBuilder('Marca: ', vehicle.brand),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.5,
                              child: _buildImage(driver.photo),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: _buildImage(vehicle.photoCar),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('Datos del contrato', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  // Form fields for contract details
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onChanged: (value) {
                        createContractForm.description = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Asunto',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        createContractForm.subject = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Monto',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        createContractForm.amount = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cantidad de carga o personas',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        createContractForm.quantity = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          String formattedDate = DateFormat('dd-MM-yyyy').format(date);

                          setState(() {
                            dateController.text = formattedDate;
                          });

                          createContractForm.date = dateFormat.parse(dateController.text);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: timeArrivalController,
                      decoration: InputDecoration(
                        labelText: 'Hora de llegada',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        final arrivalTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                        if (arrivalTime != null) {
                          DateTime now = DateTime.now();
                          String formattedTime = DateFormat('hh:mm:ss').format(DateTime(now.year, now.month, now.day, arrivalTime.hour, arrivalTime.minute));

                          setState(() {
                            timeArrivalController.text = formattedTime;
                          });

                          createContractForm.timeArrival = timeFormat.parse(timeArrivalController.text);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: timeDepartureController,
                      decoration: InputDecoration(
                        labelText: 'Hora de salida',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        final arrivalTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                        if (arrivalTime != null) {
                          DateTime now = DateTime.now();
                          String formattedTime = DateFormat('hh:mm:ss').format(DateTime(now.year, now.month, now.day, arrivalTime.hour, arrivalTime.minute));

                          setState(() {
                            timeDepartureController.text = formattedTime;
                          });

                          createContractForm.timeDeparture = timeFormat.parse(timeDepartureController.text);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Servicio desde',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        createContractForm.serviceFrom = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Servicio hasta',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        createContractForm.serviceTo = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Perform form submission
                            if (createContractForm.validateForm()) {
                              // Form is valid, proceed with contract creation
                              createContractForm.createContract(vehicle);
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(15, 21, 163, 1),
                          ),
                          child: Text('Crear'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(photoUrl) {
    if (photoUrl.isEmpty) photoUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR5aeaMWVY5qsi9-dOQxxbL2U4d6qVylkDR-MrHINiwAuU0NuF2I1fwfF08GZ3nZxLVCk&usqp=CAU";

    return Image.network(photoUrl, fit: BoxFit.scaleDown);
  }

  Widget _vehicleAttributeBuilder(String label, String value) => Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    ),
  );
}