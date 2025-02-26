import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({super.key});

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List<dynamic> _listdata = [];
  bool _loading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(Uri.parse('http://180.244.133.180/api_produk/read.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Jika API mengembalikan objek dengan key tertentu, sesuaikan aksesnya
        if (data is Map<String, dynamic> && data.containsKey('produk')) {
          setState(() {
            _listdata = data['produk']; // Ambil daftar produk dari key 'produk'
            _loading = false;
          });
        } else if (data is List) {
          setState(() {
            _listdata = data; // Jika langsung berupa List, gunakan langsung
            _loading = false;
          });
        } else {
          throw Exception("Format data tidak sesuai");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Produk'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _listdata.isEmpty
              ? const Center(child: Text("No products found"))
              : ListView.builder(
                  itemCount: _listdata.length,
                  itemBuilder: (context, index) {
                    var produk = _listdata[index];
                    return Card(
                      child: ListTile(
                        title: Text(produk['nama_produk']?.toString() ?? 'No Name'),
                        subtitle: Text('Rp ${produk['harga_produk']?.toString() ?? 'No Price'}'),
                      ),
                    );
                  },
                ),
    );
  }
}
