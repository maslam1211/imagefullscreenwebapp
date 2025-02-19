import 'package:flutter/material.dart';
import 'package:image_resolution/screens/%20home_page.dart';
import 'package:image_resolution/utilities/html_image_registry.dart';

void main() {
  registerImageElement(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Fullscreen Web App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  HomePage(),
    );
  }
}
