import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:myfirstproject/auth/product/api_add_data.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/auth/product/get_product.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/home/product/update_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/dimensions.dart';
import '../../model/data_model.dart';
import 'add_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  final ApiProduct apiProduct = ApiProduct(DioClient());
  final ApiAddData _apiAddData = ApiAddData(DioClient());
  late Future<List<DataModel>> futureApiList;
  String? jwtToken;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadJwtToken().then((_) {
      setState(() {
        futureApiList = getData();
      });
    });
  }

  Future<void> _loadJwtToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken');
    } catch (e) {
      throw Exception('Error occurred $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.height45),
          child: GradientAppBar(
            gradient: const LinearGradient(colors: [AppColors.blueBgColor, AppColors.mainColor]),
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
                  padding: EdgeInsets.only(right: Dimensions.width20),
                  child: Image.asset(
                    'assets/images/Add.png',
                    color: Colors.white,
                    width: Dimensions.width30,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.blueBgColor, AppColors.mainColor])),
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
            padding: EdgeInsets.only(
                left: Dimensions.width10,
                top: Dimensions.width10,
                right: Dimensions.width10),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search product name',
                    suffixIcon: const Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
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
                                margin: EdgeInsets.symmetric(
                                    vertical: Dimensions.height5,
                                    horizontal: Dimensions.width5),
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.height10),
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
                                                    builder: (_) => UpdateProduct(
                                                        product:
                                                            product.toJson(),
                                                        onUpdate: getData)),
                                              ).then((_) {
                                                setState(() {
                                                  futureApiList = getData();
                                                });
                                              });
                                            },
                                            child: SizedBox(
                                                width: Dimensions.iconSize30,
                                                child: Image.asset(
                                                  'assets/images/Edit.png',
                                                )),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width37),
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
                                            padding: EdgeInsets.only(
                                                left: Dimensions.width28),
                                            child: customText('Unit Price',
                                                ' : ${apiList[index].unitPrice?.toStringAsFixed(2) ?? "N/A"}'),
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                var id =
                                                    apiList[index].productId;

                                                await _apiAddData
                                                    .userDeleteData(
                                                        jwtToken!, id!);

                                                setState(() {
                                                  futureApiList = getData();
                                                });
                                              },
                                              child: SizedBox(
                                                  width: Dimensions.iconSize30,
                                                  child: Image.asset(
                                                    'assets/images/delete.png',
                                                  ))),
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
    if (jwtToken != null) {
      var result = await apiProduct.getProducts(jwtToken!);
      return result.map((json) => DataModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}

Widget customText(String title, String subtitle) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: title,
          style: TextStyle(
              color: const Color(0xff8D8D8D), fontSize: Dimensions.font14),
        ),
        TextSpan(
          text: subtitle,
          style: TextStyle(
              color: const Color(0xff1D46A4), fontSize: Dimensions.font14),
        ),
      ],
    ),
  );
}
