import 'package:flutter/material.dart';
import '../../features/auth/verify_otp_page.dart';
import '../../features/auth/verify_otp_mobile.dart';
import '../../services/auth_service.dart';
import 'mobile_home.dart';

class CompleteRegisterMobile extends StatefulWidget {
  final String login;

  const CompleteRegisterMobile({
    super.key,
    required this.login,
  });

  @override
  State<CompleteRegisterMobile> createState() =>
      _CompleteRegisterMobileState();
}

class _CompleteRegisterMobileState
    extends State<CompleteRegisterMobile> {

  final TextEditingController fullnameController =
      TextEditingController();

  final TextEditingController usernameController =
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 10),

                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),

                const SizedBox(height: 30),

                const Text(
                  "Lengkapi akun Anda",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Masukkan nama lengkap, username, dan kata sandi untuk membuat akun.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 35),

                // FULLNAME
                TextField(
                  controller: fullnameController,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",

                    labelStyle: const TextStyle(
                      color: Colors.white54,
                    ),

                    filled: true,
                    fillColor:
                        const Color(0xFF1C1C1E),

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
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

                // USERNAME
                TextField(
                  controller: usernameController,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(
                    labelText: "Username",

                    labelStyle: const TextStyle(
                      color: Colors.white54,
                    ),

                    filled: true,
                    fillColor:
                        const Color(0xFF1C1C1E),

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
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
                    labelText: "Kata Sandi",

                    labelStyle: const TextStyle(
                      color: Colors.white54,
                    ),

                    filled: true,
                    fillColor:
                        const Color(0xFF1C1C1E),

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
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

                const SizedBox(height: 35),

                // REGISTER BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    onPressed: () async {

                      final result = await AuthService.register(
                        fullname: fullnameController.text,
                        username: usernameController.text,
                        login: widget.login,
                        password: passwordController.text,
                        birthDay: 1,
                        birthMonth: 1,
                        birthYear: 2000,
                      );

                      if (result['success'] == true) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VerifyOtpMobile(
                              login: widget.login,
                            ),
                            ),
                          );
                        } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result['message'] ?? 'Register gagal',
                            ),
                          ),
                        );

                      }
                    },

                    style: ElevatedButton.styleFrom(
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
                      "Daftar",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 300),

                const Center(
                  child: Text(
                    "Saya sudah memiliki akun",

                    style: TextStyle(
                      color:
                          Color(0xFF0095F6),
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }
}