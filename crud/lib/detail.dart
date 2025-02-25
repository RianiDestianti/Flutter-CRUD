import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;

  const Detail({super.key, required this.index, required this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['item_name']}"),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {},
                      child: const Text("EDIT"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {},
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
