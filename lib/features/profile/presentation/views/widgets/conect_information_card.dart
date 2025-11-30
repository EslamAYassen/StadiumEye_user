import 'package:flutter/material.dart';

class ContectInformationCard extends StatelessWidget {
  const ContectInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 2),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.email_outlined),
              title: Text("Email", style: TextStyle(fontSize: 13)),
              subtitle: Text(
                'john.smith@company.com',
                style: TextStyle(fontSize: 15),
              ),
              visualDensity: VisualDensity(vertical: -3),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.phone_outlined),
              title: Text("phone", style: TextStyle(fontSize: 13)),
              subtitle: Text(
                '+1 (555) 123-4567',
                style: TextStyle(fontSize: 15),
              ),
              visualDensity: VisualDensity(vertical: -3),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on_outlined),
              title: Text("location", style: TextStyle(fontSize: 13)),
              subtitle: Text(
                'San Francisco, CA',
                style: TextStyle(fontSize: 15),
              ),
              visualDensity: VisualDensity(vertical: -3),
            ),
          ],
        ),
      ),
    );
  }
}
