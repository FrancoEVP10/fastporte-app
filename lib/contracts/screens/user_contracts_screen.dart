import 'package:fastporte_app/contracts/model/contract.dart';
import 'package:fastporte_app/contracts/services/contract_service.dart';
import 'package:fastporte_app/contracts/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserContractsScreen extends StatefulWidget {
  const UserContractsScreen({Key? key}) : super(key: key);

  @override
  State<UserContractsScreen> createState() => _UserContractsScreenState();
}

class _UserContractsScreenState extends State<UserContractsScreen> {
  final contractsService = ContractService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Pending contracts",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: contractsService.getPendingContracts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final contracts = snapshot.data as List<dynamic>;
                      if (contracts.isEmpty) {
                        return const Center(
                          child: Text("No pending contracts"),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contracts.length,
                        itemBuilder: (context, index) {
                          final contract = contracts[index];
                          // print(contract);
                          if (!contract['visible']) {
                            return const SizedBox.shrink();
                          }
                          return ContractCard(
                            avatarText: "A",
                            title: "Contract $index",
                            subtitle: contract['description'],
                            summary: [
                              SummaryRow(
                                label: "Subject:",
                                value: contract['subject'],
                              ),
                            ],
                            details: [
                              DetailsRow(
                                label: "From:",
                                value: contract['from'],
                              ),
                              DetailsRow(
                                label: "To:",
                                value: contract['to'],
                              ),
                              DetailsRow(
                                label: "Date:",
                                value: contract['timeArrival'],
                              ),
                              DetailsRow(
                                label: "Time:",
                                value: contract['timeDeparture'],
                              ),
                              DetailsRow(
                                label: "Quantity:",
                                value: contract['quantity'],
                              ),
                            ],
                            amount: AmountRow(
                              label: "Amount:",
                              value: contract['amount'],
                            ),
                            onDeclinePressed: () async {
                              Contract res = await contractsService.updateContractVisible(contract['id']);
                              setState(() {
                                if (res.visible == false) {
                                  contracts[index] = res;
                                }
                              });
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}
