import 'package:flutter/material.dart';

import '../../widgets/sidebar_widget.dart';
import '../../widgets/upload_story_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';

class ProfileWeb extends StatefulWidget {
  const ProfileWeb({super.key});

  @override
  State<ProfileWeb> createState() => _ProfileWebState();
}

class _ProfileWebState extends State<ProfileWeb> {
  Map<String, dynamic>? user;

  bool isLoading = true;
  
  @override
void initState() {
  super.initState();
  loadProfile();
}

Future<void> loadProfile() async {

  final prefs =
      await SharedPreferences.getInstance();

  final userId =
      prefs.getInt('user_id');

  if (userId == null) {
    setState(() {
      isLoading = false;
    });
    return;
  }

  final result =
      await AuthService.getProfile(userId);

  if (result != null &&
      result['success'] == true) {

    setState(() {
      user = result['user'];
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: Colors.white,

      body: Row(
        children: [

          // SIDEBAR
          const SidebarWidget(),

          // CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 950,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),

                  child: Column(
                    children: [

                      // ======================
                      // HEADER PROFILE
                      // ======================
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                         // FOTO PROFIL
                          Column(
                            children: [

                              CircleAvatar(
                                radius: 75,
                                backgroundImage: const AssetImage(
                                  "assets/images/profil2.jpeg",
                                ),
                              ),

                            ],
                          ),

                          const SizedBox(width: 90),

                          // DATA USER
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                // USERNAME
                                Row(
                                  children: [

                                     Text(
                                      user?['username'] ?? '',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight:
                                            FontWeight.w500,
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 15,
                                    ),

                                    ElevatedButton(
                                      onPressed: () {},

                                      style:
                                          ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(
                                          0xffEFEFEF,
                                        ),

                                        foregroundColor:
                                            Colors.black,

                                        elevation: 0,
                                      ),

                                      child: const Text(
                                        "Edit Profil",
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    ElevatedButton(
                                      onPressed: () {},

                                      style:
                                          ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(
                                          0xffEFEFEF,
                                        ),

                                        foregroundColor:
                                            Colors.black,

                                        elevation: 0,
                                      ),

                                      child: const Text(
                                        "Lihat Arsip",
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    const Icon(
                                      Icons.settings,
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 25,
                                ),

                                // STATS
                                Row(
                                  children: [

                                    const Text(
                                      "2 kiriman",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 35,
                                    ),

                                    const Text(
                                      "54 pengikut",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 35,
                                    ),

                                    const Text(
                                      "71 diikuti",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 25,
                                ),

                                Text(
                                   user?['fullname'] ?? '',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                const Text(
                                  "Mahasiswa Sistem Informasi",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),

                      const Divider(),

                      const SizedBox(height: 15),

                      // ======================
                      // MENU TAB
                      // ======================
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: const [

                          Icon(Icons.grid_on),

                          SizedBox(width: 8),

                          Text(
                            "POSTINGAN",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 60),

                          Icon(Icons.bookmark_border),

                          SizedBox(width: 8),

                          Text(
                            "TERSIMPAN",
                          ),

                          SizedBox(width: 60),

                          Icon(Icons.person_outline),

                          SizedBox(width: 8),

                          Text(
                            "DITANDAI",
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ======================
                      // GRID POST
                      // ======================
                      GridView.count(
                        shrinkWrap: true,

                        physics:
                            const NeverScrollableScrollPhysics(),

                        crossAxisCount: 3,

                        crossAxisSpacing: 4,

                        mainAxisSpacing: 4,

                        childAspectRatio: 1,

                        children: [

                          Image.asset(
                            "assets/images/post1.png",
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            "assets/images/post2.png",
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            "assets/images/post3.png",
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            "assets/images/post1.png",
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            "assets/images/post2.png",
                            fit: BoxFit.cover,
                          ),

                          Image.asset(
                            "assets/images/post3.png",
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}