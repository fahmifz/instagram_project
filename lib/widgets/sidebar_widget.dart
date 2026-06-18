import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'upload_story_dialog.dart';
import '../screens/profile/profile_web.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.white,

      child: Column(
        children: [

          const SizedBox(height: 20),

          // LOGO INSTAGRAM
          Image.asset(
            "assets/images/instagram_icon.jpg",
            width: 30,
            height: 30,
          ),

          const SizedBox(height: 20),

          // HOME
          sidebarIcon(
            Icons.home_filled,
            isActive: true,
          ),

          sidebarIcon(Icons.smart_display_outlined),

          sidebarIcon(FeatherIcons.send),

          sidebarIcon(FeatherIcons.search),

          sidebarIcon(FeatherIcons.compass),

          // NOTIFICATION
          Stack(
            children: [

              sidebarIcon(FeatherIcons.heart),

              Positioned(
                right: 0,
                top: 12,

                child: Container(
                  width: 8,
                  height: 8,

                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

            ],
          ),

          // PUSH KE BAWAH
          const Spacer(),

          // PROFILE
          InkWell(

          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileWeb(),
              ),
            );
          },

          child: const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(
              "assets/images/side1.jpeg",
            ),
          ),
        ),

          const SizedBox(height: 15),

          // MENU
          sidebarIcon(Icons.menu),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),

            child: Image.asset(
              "assets/images/kotak.png",
              width: 22,
              height: 22,
            ),
          ),

          const SizedBox(height: 20),

        ],
      ),
    );
  }

  Widget sidebarIcon(
    IconData icon, {
    bool isActive = false,
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Icon(
        icon,
        size: 30,

        color: Colors.black,

        weight: isActive ? 900 : 400,
      ),
    );
  }
}