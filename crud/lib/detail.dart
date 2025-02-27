import 'package:flutter/material.dart';
import 'editdata.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;

  const Detail({super.key, required this.index, required this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() async {
    var url = "http://10.0.2.2/my_store/deleteData.php";
    final response = await http.post(Uri.parse(url), body: {
      'id': widget.list[widget.index]['id'], // Sesuaikan dengan kolom ID di database
    });

    if (response.statusCode == 200) {
      // Tampilkan Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil dihapus")),
      );
      // Kembali ke halaman utama setelah berhasil hapus
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menghapus data")),
      );
    }
  }

  void confirm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you sure you want to delete '${widget.list[widget.index]['item_name']}'?",
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                deleteData(); // Hapus data
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("OK DELETE!", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog tanpa menghapus
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("CANCEL", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list[widget.index]['item_name']),
      ),
      body: Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30.0),
                Text(
                  widget.list[widget.index]['item_name'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Code: ${widget.list[widget.index]['item_code']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Price: ${widget.list[widget.index]['price']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Stock: ${widget.list[widget.index]['stock']}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => EditData(
                              list: widget.list,
                              index: widget.index,
                            ),
                          ),
                        );
                      },
                      child: const Text("EDIT"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => confirm(),
                      child: const Text("DELETE"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
