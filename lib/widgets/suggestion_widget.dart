import 'package:flutter/material.dart';

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      color: Colors.white,

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            // PROFILE ATAS
            Row(
              children: [

                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    "assets/images/side1.jpeg",
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "mutttiioo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Mutia Cahi",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Alihkan",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            // TITLE
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  "Disarankan untuk Anda",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Lihat semua",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            // SUGGESTIONS
            suggestionItem(
              profile: "assets/images/side2.jpeg",
              username: "Niar",
              subtitle: "Diikuti oleh sugeng__03 + 15 lainnya",
              followImage1: "assets/images/profil_sidebarkanan1.png",
              followImage2: "",
            ),

            suggestionItem(
              profile: "assets/images/side4.jpeg",
              username: "D-VERSE 2026",
              subtitle: "Diikuti oleh fzrkaaaa + 4 lainnya",
              followImage1: "assets/images/profil_sidebarkanan2.png",
              followImage2: "",
            ),

            suggestionItem(
              profile: "assets/images/side3.jpeg",
              username: "Muhammad Hidayatu...",
              subtitle: "Diikuti oleh adiksat + 18 lainnya",
              followImage1: "assets/images/profil_sidebarkanan2.png",
              followImage2: "",
            ),

            suggestionItem(
              profile: "assets/images/side5.jpeg",
              username: "INKUBATOR BISNIS",
              subtitle: "Diikuti oleh khadijah_nurul_fitri",
              followImage1: "assets/images/profil_sidebarkanan3.png",
              followImage2: "",
            ),

            suggestionItem(
              profile: "assets/images/side6.jpeg",
              username: "PINRANG INFORMASI.",
              subtitle: "Diikuti oleh nnisaxz + 193 lainnya",
              verified: true,
              followImage1: "assets/images/profil_sidebarkanan5.png",
              followImage2: "",
            ),

            const SizedBox(height: 30),

            // FOOTER
            const Text(
              "Tentang • Bantuan • Pers • API • Pekerjaan • Privasi • Ketentuan • Lokasi • Bahasa • Verifikasi Meta\n",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const Text(
              "© 2026 INSTAGRAM FROM",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget suggestionItem({
    required String profile,
    required String username,
    required String subtitle,
    required String followImage1,
    required String followImage2,
    bool verified = false,
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(
        children: [

          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(profile),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // USERNAME + VERIFIED
                Row(
                  children: [

                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (verified) ...[
                      const SizedBox(width: 4),

                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 14,
                      ),
                    ],

                  ],
                ),

                const SizedBox(height: 4),

                // FOLLOWED BY
                Row(
                  children: [

                    CircleAvatar(
                      radius: 7,
                      backgroundImage: AssetImage(
                        followImage1,

                      ),
                    ),

                    const SizedBox(width: 2),

                    

                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        subtitle,

                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),

                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

          TextButton(
            onPressed: () {},

            child: const Text(
              "Ikuti",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
}