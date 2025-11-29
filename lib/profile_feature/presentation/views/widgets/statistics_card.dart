import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.reports,
    required this.approved,
    required this.pending,
  });
  //replace API data
  final int reports;
  final int approved;
  final int pending;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Statistics",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildStaticCard("Reports", reports),
                buildStaticCard("Approved", approved),
                buildStaticCard("Pending", pending),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Column  buildStaticCard(String title, int value) {
  return Column(
    children: [
      Text(
        value.toString(),
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
      Text(title, style: const TextStyle(color: Colors.grey, fontSize: 16)),
    ],
  );
}
