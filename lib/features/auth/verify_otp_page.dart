import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/responsive.dart';
import '../../screens/mobile/login_mobile.dart';
import '../../screens/web/login_web.dart';
import '../../core/responsive/responsive.dart';

class VerifyOtpPage extends StatefulWidget {
  final String email;

  const VerifyOtpPage({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOtpPage> createState() =>
      _VerifyOtpPageState();
}

class _VerifyOtpPageState
    extends State<VerifyOtpPage> {

  final otpController = TextEditingController();

  bool isLoading = false;

  Future<void> verify() async {

    if (otpController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Masukkan kode OTP",
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final result =
          await AuthService.verifyOtp(
        email: widget.email,
        otp: otpController.text.trim(),
      );

      if (result['success'] == true) {

        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Verifikasi berhasil",
            ),
            backgroundColor: Colors.green,
          ),
        );

        await Future.delayed(
          const Duration(seconds: 1),
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginWeb(),
          ),
        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              result['message'] ??
                  "OTP salah",
            ),
            backgroundColor: Colors.red,
          ),
        );

      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
          ),
          backgroundColor: Colors.red,
        ),
      );

    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bool isDesktop =
        Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Container(
          width: isDesktop ? 420 : double.infinity,

          margin: EdgeInsets.symmetric(
            horizontal:
                isDesktop ? 0 : 24,
          ),

          padding: EdgeInsets.all(
            isDesktop ? 40 : 24,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            border: Border.all(
              color: Colors.grey.shade300,
            ),

            borderRadius:
                BorderRadius.circular(8),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              Image.asset(
                "assets/images/instagram.png",
                width: isDesktop ? 80 : 65,
              ),

              const SizedBox(height: 25),

              const Text(
                "Masukkan Kode Verifikasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Kami telah mengirim kode OTP ke email berikut",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: otpController,

                keyboardType:
                    TextInputType.number,

                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 8,
                  fontWeight:
                      FontWeight.bold,
                ),

                decoration: InputDecoration(
                  hintText: "000000",

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      8,
                    ),
                  ),

                  contentPadding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 45,

                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : verify,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF0095F6,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),

                  child:
                      isLoading
                          ? const SizedBox(
                            width: 22,
                            height: 22,
                            child:
                                CircularProgressIndicator(
                              color:
                                  Colors
                                      .white,
                              strokeWidth:
                                  2,
                            ),
                          )
                          : const Text(
                            "Verifikasi",
                            style:
                                TextStyle(
                              color:
                                  Colors
                                      .white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  "Kembali",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}