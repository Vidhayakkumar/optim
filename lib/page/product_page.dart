import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:myfirstproject/auth/product/api_add_data.dart';
import 'package:myfirstproject/auth/dio_client.dart';
import 'package:myfirstproject/auth/product/get_product.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/page/update_product.dart';
import 'package:myfirstproject/page/add_product.dart';

import '../model/data_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  final ApiProduct apiProduct = ApiProduct(DioClient());

  final ApiAddData _apiAddData = ApiAddData(DioClient());

  late Future<List<DataModel>> futureApiList;

  String jwtToken ="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbGVuQGdtYWlsLmNvbSIsImlhdCI6MTczNTEzNDkxNSwiZXhwIjoxNzM1MzE0OTE1fQ.Y0BhggRkwEyR205-cKYPWDzT1u44t12WYQs38OjAXVEpgdh7XSjf1tkqouYwrpPMkQJMQC4CquWsdVzirDE4Lw";
  @override
  void initState() {
    super.initState();
    futureApiList = getData();
  }

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: GradientAppBar(
            gradient: const LinearGradient(colors: [blueBgColor, blueBgColor1]),
            leading: const Icon(Icons.arrow_back),
            title: const Text("Product List"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddProduct(onUpdate: getData)),
                  ).then((_) {
                    setState(() {
                      futureApiList = getData();
                    });
                  });
                },
                icon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Image.asset(
                    'assets/images/Add.png',
                    color: Colors.white,
                    width: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [blueBgColor, blueBgColor1])),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            unselectedItemColor: Colors.white38,
            selectedItemColor: Colors.white,
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
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search product name',
                    suffixIcon: const Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<DataModel>>(
                    future: futureApiList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        var apiList = snapshot.data!;
                        return ListView.builder(
                          itemCount: apiList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = apiList[index];
                            return Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Color(0xffFAFAFA),
                                    Color(0xffFFFFFF)
                                  ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight)),
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          customText('Product Name',
                                              ' : ${apiList[index].productName ?? "N/A"}'),
                                          GestureDetector(
                                            onTap: () {

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => EditScreen(
                                                        product:
                                                            product.toJson(),
                                                        onUpdate: getData)),
                                              ).then((_) {
                                                setState(() {
                                                  futureApiList = getData();
                                                });
                                              });
                                            },
                                            child: Image.asset(
                                                'assets/images/Edit.png'),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            37, 0, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            customText('Quantity',
                                                ' : ${apiList[index].quantity?.toString() ?? "N/A"}'),
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
                                            child: customText('Unit Price',
                                                ' : ${apiList[index].unitPrice?.toStringAsFixed(2) ?? "N/A"}'),
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                var id = apiList[index].productId;

                                                await _apiAddData.userDeleteData(jwtToken, id!);

                                                setState(() {
                                                  futureApiList = getData();
                                                });
                                              },
                                              child: Image.asset('assets/images/delete.png')),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No products found.'));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<DataModel>> getData() async {
    var result = await apiProduct.getProducts(jwtToken);
    return result.map((json) => DataModel.fromJson(json)).toList();
  }
}

Widget customText(String title, String subtitle) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: title,
          style: const TextStyle(color: Color(0xff8D8D8D)),
        ),
        TextSpan(
          text: subtitle,
          style: const TextStyle(color: Color(0xff1D46A4)),
        ),
      ],
    ),
  );
}
