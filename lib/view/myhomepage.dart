import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

List<dynamic> jsondata = [
  {
    "p_name": "Apple",
    "p_id": 1,
    "p_cost": 30,
    "image_url":
        "https://st2.depositphotos.com/7036298/10694/i/450/depositphotos_106948346-stock-photo-ripe-red-apple-with-green.jpg",
    "p_availability": 1,
    "p_details": "Imported from Swiss",
    "p_category": "Premium"
  },
  {
    "p_name": "Mango",
    "p_id": 2,
    "p_cost": 50,
    "image_url":
        "https://thumbs.dreamstime.com/b/fresh-mango-isolated-white-background-indian-mango-alphonso-mango-fresh-mango-isolated-white-background-indian-mango-172875697.jpg",
    "p_availability": 1,
    "p_details": "Farmed at Selam",
    "p_category": "Tamilnadu"
  },
  {
    "p_name": "Bananna",
    "p_id": 3,
    "p_cost": 5,
    "image_url":
        "https://upload.wikimedia.org/wikipedia/commons/a/aa/Bananas_%28white_background%29.jpg",
    "p_availability": 0
  },
  {
    "p_name": "Orange",
    "p_id": 4,
    "p_cost": 25,
    "image_url":
        "https://static9.depositphotos.com/1642482/1148/i/600/depositphotos_11489364-stock-photo-ripe-orange.jpg",
    "p_availability": 1,
    "p_details": "from Nagpur",
    "p_category": "Premium"
  }
];

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var items;
  bool isLoaded = false;
  int quantity = 0;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    items = jsondata;
    if (items != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("PRODUCTS"),
        centerTitle: true,
      ),
      body: isLoaded == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: items[index]["image_url"],
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  items[index]['p_name'],
                                  maxLines: 2,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text('\$${items[index]["p_cost"]}',
                                    style: const TextStyle(
                                      fontSize: 32,
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    height: 40,
                                    width: 60,
                                    child: TextFormField(
                                      initialValue: quantity.toString(),
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3, color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3, color: Colors.black),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3, color: Colors.black),
                                          ),
                                          contentPadding: EdgeInsets.all(8)),
                                      keyboardType: TextInputType.number,
                                      onChanged: ((value) {
                                        if (value == '') {
                                          quantity = 0;
                                          print(quantity);
                                        } else {
                                          quantity =
                                              int.parse(value.toString());
                                          print(quantity);
                                        }
                                      }),
                                    )),
                                InkWell(
                                  onTap: () {
                                    jsondata[index].putIfAbsent(
                                        "p_quantity", () => quantity);
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('json data'),
                                        content:
                                            Text(jsondata[index].toString()),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Text("Add Quantity",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
