import 'package:flutter/material.dart';
import 'dart:html' as html;


class ImageViewer extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDoubleTap;

  const ImageViewer({
    super.key,
    required this.imageUrl,
    required this.onDoubleTap,
  });

  
  void _updateImageSource() {
    if (imageUrl.isNotEmpty) {
      final imageElement =
          html.document.getElementById('customImage') as html.ImageElement?;
      imageElement?.src = imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateImageSource();
    return imageUrl.isNotEmpty
        ? GestureDetector(
            onDoubleTap: onDoubleTap,
            child: const HtmlElementView(viewType: 'image-element'),
          )
        : const Text('No image loaded.');
  }
}
