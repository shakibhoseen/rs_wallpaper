import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [ Center(
        child: Text('Category', style: TextStyle(color: Colors.white)),
      )],
    );
  }
}