import 'package:flutter/material.dart';
import 'package:stadium_eye/features/profile/domain/entities/userprofile_entity.dart';
class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  const ProfileHeader({super.key,required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      padding:const EdgeInsets.all(20),
      decoration:const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),

      child: Row(
        children: [
         const CircleAvatar(
            radius: 36.0,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Color(0xFF2E7D32)),
          ),

         const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.fullName,
                style:const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                profile.role,
                style:const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    )
    ;
  }
}
