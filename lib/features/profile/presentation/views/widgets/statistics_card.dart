import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  //final ReportEntity repot;
  const StatisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //replace API data
              buildStatColumn("12", 'total active user'),
              buildStatColumn('2', 'total teams'),
              buildStatColumn('1', 'total tickets'),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildStatColumn(String value, String label) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 5),
      Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
    ],
  );
}
