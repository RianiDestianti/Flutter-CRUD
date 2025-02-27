import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> addData() async {
    var url = Uri.parse("http://10.0.2.2/my_store/adddata.php");

    try {
      var response = await http.post(url, body: {
        "itemcode": itemCodeController.text,
        "itemname": itemNameController.text,
        "price": priceController.text,
        "stock": stockController.text
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data added successfully!")),
        );

        // Kosongkan field setelah input
        setState(() {
          itemCodeController.clear();
          itemNameController.clear();
          stockController.clear();
          priceController.clear();
        });

        Navigator.pop(context); // Kembali ke halaman sebelumnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to add data!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ADD DATA")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: itemCodeController,
              decoration: const InputDecoration(
                hintText: "Item Code",
                labelText: "Item Code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: itemNameController,
              decoration: const InputDecoration(
                hintText: "Item Name",
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Stock",
                labelText: "Stock",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Price",
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text("ADD DATA", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
