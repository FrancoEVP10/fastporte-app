import 'package:flutter/material.dart';

import 'amount_row.dart';
import 'details_row.dart';
import 'summary_row.dart';

class ContractCard extends StatelessWidget {
  const ContractCard({
    Key? key,
    required this.avatarText,
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.details,
    required this.amount,
    required this.onDeclinePressed,
  }) : super(key: key);

  final String avatarText;
  final String title;
  final String subtitle;
  final List<SummaryRow> summary;
  final List<DetailsRow> details;
  final AmountRow amount;
  final VoidCallback onDeclinePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Text(avatarText),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text(subtitle),
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
            ),
            ...summary,
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: details,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [amount],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onDeclinePressed,
                  child: const Text("Decline"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}