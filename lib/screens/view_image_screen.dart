import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';

import '../shared/component.dart';

class ImageViewScreen extends StatelessWidget {
  Uint8List newImage;
  ImageViewScreen(this.newImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Image Screen'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          PhotoView(
            imageProvider: MemoryImage(newImage),
            backgroundDecoration: const BoxDecoration(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 10),
            child: IconButton(
                onPressed: () async {
                  await ImageGallerySaver.saveImage(newImage,
                      quality: 60, name: "backgroundremover");
                  defaultShowToAst(
                      isError: false, msg: 'Image Saved Successfully');
                },
                icon: const Icon(
                  Icons.save_alt,
                  color: Colors.black,
                  size: 40,
                )),
          )
        ],
      ),
    );
  }
}
