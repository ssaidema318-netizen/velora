import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title: Center(child: const Text("Velora")),), body: Center(child: Text("Soon",style: Theme.of(context).textTheme.displayMedium,),));
  }
}