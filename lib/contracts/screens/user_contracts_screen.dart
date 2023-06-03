import 'package:fastporte_app/contracts/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserContractsScreen extends StatefulWidget {
  const UserContractsScreen({Key? key}) : super(key: key);

  @override
  State<UserContractsScreen> createState() => _UserContractsScreenState();
}

class _UserContractsScreenState extends State<UserContractsScreen> {
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
                ContractCard(
                  avatarText: "A",
                  title: "Contract 1",
                  subtitle: "Contract 1 description",
                  summary: const [
                    SummaryRow(
                      label: "Subject:",
                      value: "Turistic Visit",
                    ),
                  ],
                  details: const [
                    DetailsRow(
                      label: "From:",
                      value: "Avenida Arica 123, Lima, Peru",
                    ),
                    DetailsRow(
                      label: "To:",
                      value: "Ciudad de Caral, Lomas de Lachay",
                    ),
                    DetailsRow(
                      label: "Date:",
                      value: "21/10/2023",
                    ),
                    DetailsRow(
                      label: "Time:",
                      value: "8:00 - 20:00",
                    ),
                    DetailsRow(
                      label: "Quantity:",
                      value: "15 personas",
                    ),
                  ],
                  amount: const AmountRow(
                    label: "Amount:",
                    value: "S/ 1560",
                  ),
                  onDeclinePressed: () {},
                ),
                ContractCard(
                  avatarText: "A",
                  title: "Contract 1",
                  subtitle: "Contract 1 description",
                  summary: const [
                    SummaryRow(
                      label: "Subject:",
                      value: "Turistic Visit",
                    ),
                  ],
                  details: const [
                    DetailsRow(
                      label: "From:",
                      value: "Avenida Arica 123, Lima, Peru",
                    ),
                    DetailsRow(
                      label: "To:",
                      value: "Ciudad de Caral, Lomas de Lachay",
                    ),
                    DetailsRow(
                      label: "Date:",
                      value: "21/10/2023",
                    ),
                    DetailsRow(
                      label: "Time:",
                      value: "8:00 - 20:00",
                    ),
                    DetailsRow(
                      label: "Quantity:",
                      value: "15 personas",
                    ),
                  ],
                  amount: const AmountRow(
                    label: "Amount:",
                    value: "S/ 1560",
                  ),
                  onDeclinePressed: () {},
                )
              ],
            ),
          )
        )
      ),
    );
  }
}
