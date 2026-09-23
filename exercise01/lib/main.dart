import 'package:flutter/material.dart';
import 'products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListViewExamples(),
    );
  }
}

class ListViewExamples extends StatelessWidget {
  const ListViewExamples({super.key});

  Widget productItem(Map<String, dynamic> product) {
    return ListTile(
      title: Text(product["Product Name"]),
      subtitle: Text(
        "\$${product["Price"].toStringAsFixed(2)}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("ListView")),
          bottom: const TabBar(
            tabs: [
              Tab(text: "ListView"),
              Tab(text: "Builder"),
              Tab(text: "Separated"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 1. ListView()
            ListView(
              children: products.map((product) {
                return productItem(product);
              }).toList(),
            ),

            // 2. ListView.builder()
            ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return productItem(products[index]);
              },
            ),

            // 3. ListView.separated()
            ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return productItem(products[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  thickness: 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
