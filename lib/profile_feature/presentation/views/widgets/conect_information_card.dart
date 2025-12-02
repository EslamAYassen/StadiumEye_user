import 'package:flutter/material.dart';
class ContactInformationCard extends StatelessWidget {
  const ContactInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      padding:const EdgeInsets.all(20),
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          buildContactItem(Icons.email_outlined, 'Email', 'john.smith@company.com'),
          const SizedBox(height: 12),
          buildContactItem(Icons.phone_outlined, 'Phone', '+1 (555) 123-4567'),
          const SizedBox(height: 12),
          buildContactItem(Icons.location_on_outlined, 'Location', 'San Francisco, CA'),
        ],
      ),
    );
  }
}
Widget buildContactItem(IconData icon, String title, String subtitle) {
  return  Row(
    children: [
      Icon(icon, color: Colors.grey[600], size: 22),
     const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
         const SizedBox(height: 2),
          Text(
            subtitle,
            style:const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  );
}