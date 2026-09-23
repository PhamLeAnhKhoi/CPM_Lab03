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
      title: 'GridView Exercise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GridViewPage(),
    );
  }
}

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {

  // Store the indexes of selected products
  final Set<int> selectedItems = {};

  void toggleSelection(int index) {
    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index);
      } else {
        selectedItems.add(index);
      }
    });
  }

  Widget productCard(int index) {
    final product = products[index];
    final isSelected = selectedItems.contains(index);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      color: isSelected ? Colors.grey[400] : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          // Normal tap - ripple effect
        },
        onLongPress: () {
          toggleSelection(index);
        },
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product["Product Name"].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      product["Price"].toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Check icon when selected
            if (isSelected)
              const Center(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 28,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // METHOD 1: GridView()
  Widget normalGridView() {
    return GridView(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.95,
      ),

      children: List.generate(
        products.length,
        (index) => productCard(index),
      ),
    );
  }

  // METHOD 2: GridView.builder()
  Widget builderGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(5),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.95,
      ),

      itemCount: products.length,

      itemBuilder: (context, index) {
        return productCard(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'GridView',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'GridView'),
              Tab(text: 'GridView.builder'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            normalGridView(),
            builderGridView(),
          ],
        ),
      ),
    );
  }
}