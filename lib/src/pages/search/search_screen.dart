import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بحث')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'ابحث عن صنف أو مطعم',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (_) {},
        ),
      ),
    );
  }
}