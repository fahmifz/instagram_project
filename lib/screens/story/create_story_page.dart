import 'dart:io';
import 'dart:typed_data';

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
      print('=== REQUEST PERMISSION ===');

      final storageStatus =
    await Permission.photos.request();

print(
  'PHOTOS PERMISSION = $storageStatus',
);

if (!storageStatus.isGranted) {

  await openAppSettings();

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
        print('ALBUM KOSONG');

        setState(() {
          isLoading = false;
        });

        return;
      }

      final recentAlbum = albums.first;

      final media =
          await recentAlbum.getAssetListPaged(
        page: 0,
        size: 300,
      );

      print(
        'TOTAL FOTO = ${media.length}',
      );

      print(
        'NAMA ALBUM = ${recentAlbum.name}',
      );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        title: const Text(
          'Tambahkan Cerita',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: isLoading
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
                      const EdgeInsets.all(2),

                  itemCount: images.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),

                  itemBuilder:
                      (context, index) {
                    final asset =
                        images[index];

                    return FutureBuilder<
                        Uint8List?>(
                      future:
                          asset.thumbnailDataWithSize(
                        const ThumbnailSize(
                          300,
                          300,
                        ),
                      ),

                      builder:
                          (context, snapshot) {
                        if (!snapshot
                            .hasData) {
                          return Container(
                            color: Colors
                                .grey
                                .shade900,
                          );
                        }

                        return GestureDetector(
                          onTap: () async {
                            final file =
                                await asset.file;

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
                              Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}