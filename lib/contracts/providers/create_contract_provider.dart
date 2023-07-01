import 'package:fastporte_app/vehicle/model/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:fastporte_app/globals.dart' as globals;
import '../../auth/services/user_service.dart';
import '../services/contract_service.dart';

class CreateContractProvider with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String description = '';
  String subject = '';
  String amount = '';
  String quantity = '';
  DateTime date = DateTime.now();
  DateTime timeArrival = DateTime.now();
  DateTime timeDeparture = DateTime.now();
  String serviceFrom = '';
  String serviceTo = '';

  final userService = UserService();
  final contractService = ContractService();
  // DateFormat timeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");

  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  void createContract(Vehicle vehicle) async {
    final user = await userService.getUserById(globals.localId);
    final driver = vehicle.driver;

    //format data for post body request
    Map<String, String> body = {
      'amount': amount,
      'contractDate': date.toIso8601String(),
      'description': description,
      'from': serviceFrom,
      'quantity': quantity,
      'subject': subject,
      'timeArrival': timeArrival.toIso8601String(),
      'timeDeparture': timeDeparture.toIso8601String(),
      'to': serviceTo,
      'visible': 'true',
    };

    final response = await contractService.createContract(user.id, driver.id, body);
    print(response);
  }
}
