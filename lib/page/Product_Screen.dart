import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstproject/auth/dio_client.dart';
import 'package:myfirstproject/auth/get_product.dart';
import 'package:myfirstproject/page/Edit_Product.dart';
import 'package:myfirstproject/page/Update_product.dart';

import '../config/colors.dart';
import '../data_model.dart';
import '../main.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
 
  final ApiProduct apiProduct=ApiProduct(DioClient());
  var result;


   List<DataModel> apiList= <DataModel>[];

  String jwtToken="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbGVuQGdtYWlsLmNvbSIsImlhdCI6MTczNDQxNTYxNCwiZXhwIjoxNzM0NTk1NjE0fQ.vuDWTrcBeNYqDFbOF4TECA3e3nbSQ8czBbEu4qmHdMJkOjMA9q3gaIgNJy9j0sPQxsqZnvw3UJ1kw925_qXgxw";

  @override
  void initState() {

    super.initState();
    getData();
  }



  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;



    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Product List"),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
                onPressed: () {
                  // customBottomSheetAdd();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UpdateScreen()));
                },
                icon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Image.asset(
                    'assets/images/Add.png',
                    color: Colors.white,
                    width: 30,
                  ),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blueGrey,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active),
                  label: "Notifications"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.alarm), label: 'Reminder'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile')
            ]),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Search contact name',
                      suffixIcon: Icon(Icons.search),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0))),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:5,
                      itemBuilder: (BuildContext context, int index) {
                        return Card (
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row (
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [



                                    customText('Product Name', ' : ${apiList[index].productName} '),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      EditScreen()));
                                        },
                                        child: Image.asset(
                                            'assets/images/Edit.png'))
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(37, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      customText('Quantity', ' : 20'),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          28, 0, 0, 0),
                                      child: customText('Unit price', ' : 11'),
                                    ),
                                    Image.asset('assets/images/delete.png')
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> getData()async{
     result =await apiProduct.getProducts(jwtToken);
    apiList.add(result.toString() as DataModel);
        //.map((item)=>DataModel.fromJson(item)).toList().cast<DataModel>());
        //DataModel.fromJson(item))
    // .toList()
    // .cast<DataModel>();
  }

}

Widget customText(String title, String subtitle) {
  return RichText(
      text: TextSpan(children: [
    TextSpan(text: title, style: TextStyle(color: Color(0xff8D8D8D))),
    TextSpan(text: subtitle, style: TextStyle(color: Color(0xff1D46A4))),
  ]));
}
