import 'package:ecommerce_bloc/home/view/home_view.dart';
import 'package:flutter/material.dart';

late double height;
late double width;
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
