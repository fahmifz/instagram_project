import 'package:flutter/material.dart';
import 'login_mobile.dart';
import 'CompleteRegisterMobile.dart';

class RegisterMobile extends StatefulWidget {
  const RegisterMobile({super.key});

  @override
  State<RegisterMobile> createState() =>
      _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {

  final TextEditingController emailController =
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

                // BACK
                IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginMobile(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // TITLE
                const Text(
                  "Berapa alamat email Anda?",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Masukkan alamat email aktif. Kami akan mengirimkan kode OTP untuk verifikasi akun.\nTidak ada yang akan melihat informasi ini di profil Anda.",

                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 35),

                // PHONE
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(
                    labelText: "Email",

                    labelStyle: const TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),

                    filled: true,
                    fillColor: const Color(0xFF1C1C1E),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // INFO TEXT
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),

                    children: [

                      TextSpan(
                        text:
                            "Anda mungkin menerima notifikasi WhatsApp dan SMS dari kami. ",
                      ),

                      TextSpan(
                        text: "Pelajari selengkapnya",

                        style: TextStyle(
                          color: Color(0xFF0095F6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // NEXT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CompleteRegisterMobile(
                            email: emailController.text,
                          ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0095F6),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                    ),

                    child: const Text(
                      "Berikutnya",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // EMAIL BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF1C1C1E),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                      ),

                      elevation: 0,
                    ),

                    child: const Text(
                      "Daftar dengan email",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 260),

                // LOGIN
                const Center(
                  child: Text(
                    "Saya sudah memiliki akun",

                    style: TextStyle(
                      color: Color(0xFF0095F6),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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