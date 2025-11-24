import 'package:flutter/material.dart';
import 'package:stadium_eye/profile_feature/presentation/views/widgets/conect_information_card.dart';
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width:double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green[800],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                child: CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person_outline, size: 45,color: Colors.green[800],),

                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'John Smith',
                    style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Field Reporter',
                    style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                  ),
                ],
              ),

            ],

          ),
        ),
        Positioned(
          bottom: -195,
          left: 20,
          right: 20,
          child:ContectInformationCard(),),
      ],
    );

  }
}
