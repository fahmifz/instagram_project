import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final String username;
  final String image;

  const StoryWidget({
    super.key,
    required this.username,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    final isMobile =
        MediaQuery.of(context).size.width < 700;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),

      child: Column(
        children: [

            Container(
                padding: const EdgeInsets.all(3),

                decoration: const BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.orange,
                    ],
                  ),
                ),

                child: ClipOval(
                  child: Image.network(
                    image,
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {

                      print("========== IMAGE ERROR ==========");
                      print(error);
                      print("================================");

                      return Container(
                        width: 58,
                        height: 58,
                        color: Colors.red,
                        child: const Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ), // <-- PENUTUP CONTAINER YANG HILANG

              const SizedBox(height: 6),

          SizedBox(
            width: 70,

            child: Text(
              username,
              overflow:
                  TextOverflow.ellipsis,

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 12,
                color: isMobile
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}