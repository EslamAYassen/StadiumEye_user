import 'package:flutter/material.dart';
import 'package:stadium_eye/features/profile/presentation/views/widgets/conect_information_card.dart';
import 'package:stadium_eye/theme/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                child: CircleAvatar(
                  radius: 45,
                  child: Icon(
                    Icons.person_outline,
                    size: 45,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'John Smith',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Field Reporter',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: -195,
          left: 20,
          right: 20,
          child: ContectInformationCard(),
        ),
      ],
    );
  }
}
