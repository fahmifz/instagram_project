import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../screens/web/login_web.dart';

class VerifyOtpWeb extends StatefulWidget {
  final String email;

  const VerifyOtpWeb({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOtpWeb> createState() =>
      _VerifyOtpWebState();
}

class _VerifyOtpWebState
    extends State<VerifyOtpWeb> {
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
        email: widget.email,
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
            builder: (_) => const LoginWeb(),
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
      backgroundColor: Colors.white,

      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(40),

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/instagram.png",
                width: 90,
              ),

              const SizedBox(height: 25),

              const Text(
                "Masukkan Kode OTP",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                widget.email,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              TextField(
                controller: otpController,
                textAlign: TextAlign.center,

                decoration: InputDecoration(
                  hintText: "000000",
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed:
                      isLoading ? null : verify,

                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Verifikasi",
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