import'package:flutter/material.dart';
class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key, required this.reports, required this.approved, required this.pending});
  //replace API data
  final int reports;
  final int approved;
  final int pending;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Statistics",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                build_static_card("Reports", reports),
                build_static_card("Approved", approved),
                build_static_card("Pending", pending),
              ],
            ),
          ],
        ),
      ),
    ) ;
  }
}
Column build_static_card(String title,int value){
  return Column(
    children: [
      Text(value.toString(),style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      Text(title, style: TextStyle(color: Colors.grey,fontSize: 16)),
    ],
  );
}
