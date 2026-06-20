import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import 'story_preview_page.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  State<CreateStoryPage> createState() =>
      _CreateStoryPageState();
}

class _CreateStoryPageState
    extends State<CreateStoryPage> {
  List<AssetEntity> images = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGallery();
  }

  Future<void> loadGallery() async {
    try {
      print(
        '=== REQUEST PERMISSION ===',
      );

      final status =
          await Permission.photos.request();

      print(
        'PHOTOS PERMISSION = $status',
      );

      if (!status.isGranted) {
        await openAppSettings();

        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        return;
      }

      final albums =
          await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      print(
        'TOTAL ALBUM = ${albums.length}',
      );

      if (albums.isEmpty) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        return;
      }

      AssetPathEntity recentAlbum =
          albums.first;

      for (final album in albums) {
        print(
          'ALBUM = ${album.name}',
        );

        final count =
            await album.assetCountAsync;

        print(
          'TOTAL = $count',
        );

        if (album.name
            .toLowerCase()
            .contains('camera')) {
          recentAlbum = album;
          break;
        }
      }

      print(
        'ALBUM DIPILIH = ${recentAlbum.name}',
      );

      final allMedia =
          await recentAlbum.getAssetListPaged(
        page: 0,
        size: 300,
      );

      List<AssetEntity> media = [];

      for (final item in allMedia) {
        try {
          final file =
              await item.file;

          if (file != null &&
              await file.exists()) {
            final size =
                await file.length();

            if (size > 0) {
              media.add(item);
            }
          }
        } catch (_) {}
      }

      print(
        'TOTAL FOTO = ${media.length}',
      );

      if (media.isNotEmpty) {
        final firstFile =
            await media.first.file;

        print(
          'FILE PERTAMA = ${firstFile?.path}',
        );
      }

      if (!mounted) return;

      setState(() {
        images = media;
        isLoading = false;
      });
    } catch (e) {
      print(
        'ERROR LOAD GALLERY = $e',
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTopMenu() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: menuCard(
              Icons.auto_awesome,
              'Template',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: menuCard(
              Icons.music_note,
              'Musik',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: menuCard(
              Icons.grid_view_rounded,
              'Kolase',
            ),
          ),
        ],
      ),
    );
  }

  Widget menuCard(
    IconData icon,
    String title,
  ) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xff1C1C1E),
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Tambahkan ke cerita',
          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
            fontSize: 20,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: Column(
  children: [

    buildTopMenu(),

    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: const [

              Text(
                'Terbaru',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              SizedBox(width: 4),

              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              color:
                  const Color(0xff1C1C1E),
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: Row(
              children: const [

                Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.white,
                  size: 18,
                ),

                SizedBox(width: 6),

                Text(
                  'Pilih',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),

    const SizedBox(height: 10),

    Expanded(
            child: isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )
                : images.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada foto ditemukan',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding:
                            const EdgeInsets.all(
                          2,
                        ),
                        itemCount:
                            images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing:
                              2,
                          mainAxisSpacing:
                              2,
                        ),
                        itemBuilder:
                            (context, index) {
                          final asset =
                              images[index];

                          return GestureDetector(
                            onTap: () async {
                              final file =
                                  await asset
                                      .file;

                              if (file ==
                                  null) {
                                return;
                              }

                              if (!context
                                  .mounted) {
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      StoryPreviewPage(
                                    imageFile:
                                        File(
                                      file.path,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child:
                                FutureBuilder<
                                    File?>(
                              future:
                                  asset.file,
                              builder:
                                  (context,
                                      snapshot) {
                                if (snapshot
                                        .connectionState ==
                                    ConnectionState
                                        .waiting) {
                                  return Container(
                                    color: Colors
                                        .grey
                                        .shade900,
                                  );
                                }

                                if (!snapshot
                                        .hasData ||
                                    snapshot
                                            .data ==
                                        null) {
                                  return Container(
                                    color: Colors
                                        .grey
                                        .shade900,
                                    child:
                                        const Icon(
                                      Icons
                                          .image,
                                      color: Colors
                                          .white30,
                                    ),
                                  );
                                }

                                return Image.file(
                                  snapshot
                                      .data!,
                                  fit: BoxFit
                                      .cover,
                                  errorBuilder:
                                      (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return Container(
                                      color: Colors
                                          .grey
                                          .shade900,
                                      child:
                                          const Icon(
                                        Icons
                                            .broken_image,
                                        color: Colors
                                            .white30,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}