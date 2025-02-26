import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  const EditData({super.key, required this.list, required this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemCodeController.text = widget.list[widget.index]['item_code'];
    itemNameController.text = widget.list[widget.index]['item_name'];
    priceController.text = widget.list[widget.index]['price'].toString();
    stockController.text = widget.list[widget.index]['stock'].toString();
  }

  Future<void> editData() async {
    var url = "http://10.0.2.2/my_store/editdata.php";

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "id": widget.list[widget.index]['id'],
          "itemcode": itemCodeController.text,
          "itemname": itemNameController.text,
          "price": priceController.text,
          "stock": stockController.text
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil diperbarui")),
        );

        // Navigasi setelah berhasil update
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal memperbarui data")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EDIT DATA")),
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
              onPressed: () async {
                await editData(); // Tunggu editData() selesai
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text("EDIT DATA", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
