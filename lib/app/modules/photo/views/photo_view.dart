import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../controllers/photo_controller.dart';

class PhotoView extends GetView<PhotoController> {
  const PhotoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<PhotoController>(
            builder: (context) {
              return PhotoViewGallery.builder(
                itemCount: controller.listImg.length,
                pageController: controller.pageController,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: controller.imgType == 'network'
                        ? NetworkImage(controller.listImg[index])
                        : FileImage(File(controller.listImg[index])),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                  );
                },
              );
            },
          ),
          SafeArea(
            child: InkWell(
              onTap: () => controller.handleBackBtn(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
