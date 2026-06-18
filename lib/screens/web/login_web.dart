import 'package:flutter/material.dart';

import 'register_web.dart';
import 'web_home.dart';
import '../../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {

  final TextEditingController loginController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Row(
        children: [

          // LEFT SIDE
          Expanded(
            child: Container(
              color: Colors.white,

              child: Center(
                child: Image.asset(
                  "assets/images/login_web.png",

                  width: 500,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // DIVIDER
          Container(
            width: 1,
            color: Colors.grey.shade300,
          ),

          // RIGHT SIDE
          Expanded(
            child: Center(
              child: SizedBox(
                width: 450,

                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // TITLE
                    const Text(
                      "Log into Instagram",

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // EMAIL
                    TextField(
                      controller: loginController,
                      decoration: InputDecoration(
                        hintText:
                            "Mobile number, username or email",

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide: BorderSide(
                            color:
                                Colors.grey.shade300,
                          ),
                        ),

                        enabledBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide: BorderSide(
                            color:
                                Colors.grey.shade300,
                          ),
                        ),

                        focusedBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                              const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // PASSWORD
                    TextField(
                      controller: passwordController,
                      obscureText: true,

                      decoration: InputDecoration(
                        hintText: "Password",

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide: BorderSide(
                            color:
                                Colors.grey.shade300,
                          ),
                        ),

                        enabledBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide: BorderSide(
                            color:
                                Colors.grey.shade300,
                          ),
                        ),

                        focusedBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                              const BorderSide(
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

                          print("LOGIN RESPONSE = $result");

                          if (result['success'] == true) {

                          final prefs =
                              await SharedPreferences.getInstance();

                          await prefs.setInt(
                            'user_id',
                            result['data']['id'],
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WebHome(),
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
                              const Color(
                            0xFF4EA3FF,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              30,
                            ),
                          ),

                          elevation: 0,
                        ),

                        child: const Text(
                          "Log in",

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // FORGOT PASSWORD
                    const Center(
                      child: Text(
                        "Forgot password?",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // FACEBOOK BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: OutlinedButton.icon(
                        onPressed: () {},

                        icon: const Icon(
                          Icons.facebook,
                          color:
                              Color(0xFF1877F2),
                        ),

                        label: const Text(
                          "Log in with Facebook",

                          style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),

                        style:
                            OutlinedButton.styleFrom(
                          side: BorderSide(
                            color:
                                Colors.grey.shade300,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

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
                                  const RegisterWeb(),
                            ),
                          );
                        },

                        style:
                            OutlinedButton.styleFrom(
                          side: BorderSide(
                            color:
                                Colors.grey.shade300,
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
                          "Create new account",

                          style: TextStyle(
                            color:
                                Color(0xFF4EA3FF),
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // META
                    Center(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Image.asset(
                            "assets/images/meta.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(width: 4),

                          const Text(
                            "Meta",

                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}