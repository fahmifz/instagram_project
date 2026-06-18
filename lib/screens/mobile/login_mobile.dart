import 'package:flutter/material.dart';

import 'register_mobile.dart';
import 'mobile_home.dart';
import '../../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {

  final TextEditingController loginController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1014),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 10),

                // TOP BAR
                Row(
                  children: [

                    const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),

                    const Spacer(),

                    Row(
                      children: [

                        const Text(
                          "\n\nBahasa Indonesia",

                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(width: 4),

                        Padding(
                          padding:
                              const EdgeInsets.only(
                            top: 50,
                          ),

                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white70,
                          ),
                        ),

                      ],
                    ),

                    const Spacer(),

                  ],
                ),

                const SizedBox(height: 70),

                // INSTAGRAM LOGO
                Image.asset(
                  "assets/images/instagram.png",
                  width: 90,
                  height: 90,
                ),

                const SizedBox(height: 70),

                // USERNAME
                TextField(
                  controller: loginController,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(
                    hintText:
                        "Nama pengguna, email, atau nomor ponsel",

                    hintStyle: const TextStyle(
                      color: Colors.white54,
                    ),

                    filled: true,
                    fillColor: const Color(0xFF1C1C1E),

                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 20,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),

                      borderSide: BorderSide(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),

                      borderSide: BorderSide(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),

                      borderSide:
                          const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: true,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(
                    hintText: "Kata sandi",

                    hintStyle: const TextStyle(
                      color: Colors.white54,
                    ),

                    filled: true,
                    fillColor: const Color(0xFF1C1C1E),

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 20,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),

                      borderSide: BorderSide(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),

                      borderSide: BorderSide(
                        color: Colors.grey.shade700,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),

                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () async {

                      final result = await AuthService.login(
                        login: loginController.text,
                        password: passwordController.text,
                      );

                      print("LOGIN MOBILE = $result");
                      print("SUCCESS = ${result['success']}");

                      if (result['success'] == true) {

                        final prefs =
                            await SharedPreferences.getInstance();

                        await prefs.setInt(
                          'user_id',
                          result['data']['id'],
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MobileHome(),
                          ),
                        );

                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result['message'] ?? 'Login gagal',
                            ),
                          ),
                        );

                      }
                    },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0095F6),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),

                    child: const Text(
                      "Login",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                // FORGOT PASSWORD
                const Text(
                  "Lupa kata sandi?",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 40),

                // CREATE ACCOUNT
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const RegisterMobile(),
                        ),
                      );
                    },

                    style:
                        OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color:
                            Color(0xFF0095F6),
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),

                    child: const Text(
                      "Buat akun baru",

                      style: TextStyle(
                        color:
                            Color(0xFF0095F6),
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // META
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Image.asset(
                      "assets/images/meta.png",
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    ),

                    const SizedBox(width: 6),

                    const Text(
                      "Meta",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}