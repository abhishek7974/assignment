import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../model/productmodel.dart';



class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<ProductModel>> ReadJsonData() async {
    
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/productList.json');
   

    final list = jsonDecode(jsondata) as List<dynamic>;

    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  var items;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    
    getData();
  }

  getData() async {
    items = await ReadJsonData();
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
                                imageUrl: items[index].imageUrl.toString(),
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
                                  items[index].pName,
                                  maxLines: 2,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text('\$${items[index].pCost}',
                                    style: const TextStyle(
                                      fontSize: 32,
                                    )),
                              ],
                            ),
                            Container(
                                child: Text("add a product",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
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
