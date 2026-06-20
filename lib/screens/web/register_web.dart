import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import 'login_web.dart';
// import '../../features/auth/verify_otp_page.dart';
import '../../features/auth/verify_otp_web.dart';


class RegisterWeb extends StatefulWidget {
  const RegisterWeb({super.key});

  @override
  State<RegisterWeb> createState() => _RegisterWebState();
}

class _RegisterWebState extends State<RegisterWeb> {
  final TextEditingController fullnameController =
    TextEditingController();

final TextEditingController usernameController =
    TextEditingController();

final TextEditingController loginController =
    TextEditingController();

final TextEditingController passwordController =
    TextEditingController();
  String? selectedMonth;
  String? selectedDay;
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // FORM AREA
              SizedBox(
                width: 520,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 30),

                    // BACK
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginWeb(),
                            ),
                          );
                        },
                        child: const Text(
                          "<",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // META
                    Row(
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

                    const SizedBox(height: 25),

                    // TITLE
                    const Text(
                      "Get started on Instagram",

                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Sign up to see photos and videos from your friends.",

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // EMAIL
                    const Text(
                      "Mobile number or email",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      
                      controller: loginController,
                      decoration: InputDecoration(
                        hintText: "Mobile number or email",

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),

                        children: [

                          TextSpan(
                            text:
                                "You may receive notifications from us. ",
                          ),

                          TextSpan(
                            text:
                                "Learn how we ask for your contact information.",

                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // PASSWORD
                    const Text(
                      "Password",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

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
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // DATE OF BIRTH
                    Row(
  children: [

    Expanded(
      child: dropdownField(
        "Month",
        selectedMonth,
        List.generate(
          12,
          (i) => "${i + 1}",
        ),
        (value) {
          setState(() {
            selectedMonth = value;
          });
        },
      ),
    ),

    const SizedBox(width: 14),

    Expanded(
      child: dropdownField(
        "Day",
        selectedDay,
        List.generate(
          31,
          (i) => "${i + 1}",
        ),
        (value) {
          setState(() {
            selectedDay = value;
          });
        },
      ),
    ),

    const SizedBox(width: 14),

    Expanded(
      child: dropdownField(
        "Year",
        selectedYear,
        List.generate(
          70,
          (i) => "${2026 - i}",
        ),
        (value) {
          setState(() {
            selectedYear = value;
          });
        },
      ),
    ),

  ],
),

                    
                    // NAME
                    const Text(
                      "Name",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: fullnameController,

                      decoration: InputDecoration(
                        hintText: "Full name",

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // USERNAME
                    const Text(
                      "Username",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",

                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),

                          children: [

                            TextSpan(
                              text:
                                  "People who use our services may have uploaded your contact information to Instagram. ",
                            ),

                            TextSpan(
                              text: "Learn more.",

                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                    

                    const SizedBox(height: 18),

                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),

                        children: [

                          TextSpan(
                            text:
                                "By tapping Submit , you agree to account creation as well as Instagram's ",
                          ),

                          TextSpan(
                            text: "Terms",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          TextSpan(text: ", "),

                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          TextSpan(text: ", and "),

                          TextSpan(
                            text: "Cookie Policy",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          TextSpan(text: "."),

                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          height: 1.4,
                        ),

                        children: [
                          TextSpan(
                            text:
                                "The ",
                          ),
                          TextSpan(
                            text: "This Privacy Policy ",

                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          TextSpan(
                            text:
                                "describes the ways we can use the information we collect when you create an account. For example, we use this information to provide, personalize and improve our products, including ads.",
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // SEND BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(
                        onPressed: () async {

                          if (selectedDay == null ||
                              selectedMonth == null ||
                              selectedYear == null) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Pilih tanggal lahir terlebih dahulu",
                                ),
                              ),
                            );

                            return;
                          }
                          final result = await AuthService.register(
                            fullname: fullnameController.text,
                            username: usernameController.text,
                            login: loginController.text,
                            password: passwordController.text,
                            birthDay: int.parse(selectedDay!),
                            birthMonth: int.parse(selectedMonth!),
                            birthYear: int.parse(selectedYear!),
                          );

                          if (result['success'] == true) {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VerifyOtpWeb(
                                  login: loginController.text,
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

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                        ),

                        child: const Text(
                          "Send",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: OutlinedButton(
                        onPressed: () {},

                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.grey.shade400,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                        ),

                        child: const Text(
                          "I already have an account",

                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 60),

              // FOOTER
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    footerItem("Meta"),
                    footerItem("About"),
                    footerItem("Blog"),
                    footerItem("Work"),
                    footerItem("Help"),
                    footerItem("API"),
                    footerItem("Privacy"),
                    footerItem("Provision"),
                    footerItem("Location"),
                    footerItem("Instagram Lite"),
                    footerItem("Uploading Contacts & Non-users"),
                    footerItem("Meta Verification"),

                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Text(
                    "Indonesian ▼",

                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(width: 12),

                  Text(
                    "© 2026 Instagram from Meta",

                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownField(
  String hint,
  String? value,
  List<String> items,
  Function(String?) onChanged,
) {
  return DropdownButtonFormField<String>(
    value: value,

    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
    ),

    hint: Text(
      hint,
      style: const TextStyle(
        color: Colors.black54,
      ),
    ),

    items: items.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Text(item),
      );
    }).toList(),

    onChanged: onChanged,
  );
}

  Widget footerItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),

      child: Text(
        text,

        style: const TextStyle(
          fontSize: 12,
          color: Colors.black54,
        ),
      ),
    );
  }
}