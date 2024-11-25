import 'package:flutter/material.dart';
import 'apiservice.dart';
import 'model/ResponseMain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<ResponseMain> responseMainFuture;

  @override
  void initState() {
    super.initState();
    Apiservice apiService = Apiservice();
    responseMainFuture = apiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
      ),
      body: FutureBuilder<ResponseMain>(
        future: responseMainFuture,
        builder: (BuildContext context, AsyncSnapshot<ResponseMain> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data?.products ?? [];
            if (products.isEmpty) {
              return const Center(child: Text('No products found.'));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      product.name ?? 'No Name',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product ID: ${product.productId ?? 'N/A'}"),
                        Text("Distributor Price: ${product.distributorPrice ?? 'N/A'}"),
                        Text("MRP: ${product.mrp ?? 'N/A'}"),
                        Text("Description: ${product.description ?? 'No Description'}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
