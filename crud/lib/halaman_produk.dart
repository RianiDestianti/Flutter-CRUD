import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({super.key});

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
     final respon = await http.get(Uri.parse('http://192.168.1.15/api_produk/read.php'));

      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      } else {
        print("Failed to load data: ${respon.statusCode}");
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
        title: Text('Halaman Produk'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _listdata.isEmpty
              ? Center(child: Text("No products found"))
              : ListView.builder(
                  itemCount: _listdata.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_listdata[index]['nama_produk'] ?? 'No Name'),
                        subtitle: Text(_listdata[index]['harga_produk'] ?? 'No Price'),
                      ),
                    );
                  },
                ),
    );
  }
}
