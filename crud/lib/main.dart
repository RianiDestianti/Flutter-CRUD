import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<dynamic>> fetchData() async {
    const String url = 'http://192.168.100.212/my_store/getdata.php';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) ?? [];
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Store")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text("No data available"));
            } else {
              return ItemList(items: snapshot.data!);
            }
          }
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<dynamic> items;

  const ItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Detail(list: items, index: i),
              ),
            );
          },
          child: Card(
            child: ListTile(
              title: Text(item["item_name"] ?? "No name"),
              leading: const Icon(Icons.widgets),
              subtitle: Text("Stock: ${item["stock"] ?? "N/A"}"),
            ),
          ),
        );
      },
    );
  }
}
