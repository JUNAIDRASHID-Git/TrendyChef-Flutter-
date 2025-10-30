import 'package:flutter/material.dart';

class ProductErrorPage extends StatelessWidget {
  const ProductErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("invalid Url or The product not exist")),
    );
  }
}
