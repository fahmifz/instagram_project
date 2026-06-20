import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../screens/mobile/login_mobile.dart';

class VerifyOtpMobile extends StatefulWidget {
 final String login;

const VerifyOtpMobile({
  super.key,
  required this.login,
});

  @override
  State<VerifyOtpMobile> createState() =>
      _VerifyOtpMobileState();
}

class _VerifyOtpMobileState
    extends State<VerifyOtpMobile> {
  final otpController = TextEditingController();

  bool isLoading = false;

  Future<void> verify() async {
    if (otpController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukkan kode OTP"),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await AuthService.verifyOtp(
          login: widget.login,
        otp: otpController.text.trim(),
      );

      if (result['success'] == true) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Verifikasi berhasil"),
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
            builder: (_) => const LoginMobile(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message'] ?? 'OTP salah',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1014),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mark_email_read_outlined,
                color: Colors.white,
                size: 80,
              ),

              const SizedBox(height: 25),

              const Text(
                "Verifikasi Email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                widget.login,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: otpController,
                keyboardType:
                    TextInputType.number,

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 8,
                ),

                decoration: InputDecoration(
                  hintText: "000000",
                  filled: true,
                  fillColor:
                      const Color(0xFF1C1C1E),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      isLoading ? null : verify,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF0095F6,
                    ),
                  ),

                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Verifikasi",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}