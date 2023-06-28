import 'package:api_exam/Screen/Home/Controllor/HomeControllor.dart';
import 'package:api_exam/Screen/Home/Model/HomeModel.dart';
import 'package:api_exam/Utiles/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeControllor homeControllor = Get.put(
    HomeControllor(),
  );

  @override
  void initState() {
    super.initState();

    DBHelper.dbHelper.ChackDB();

    totalIncomeExpanse();

    setState(() {});
  }

  List<Map> l1 = [];
  num sum = 0;

  Future<void> totalIncomeExpanse() async {
    l1 = await homeControllor.readIncome();

    for (int i = 0; i < l1.length; i++) {
      sum = sum + int.parse("${l1[i]['price']}");
      print("${sum}--------------------");
    }

    print("$sum");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100.sp,
                  child: Obx(
                    () => DropdownButton(
                      dropdownColor: Colors.black,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      isExpanded: true,
                      elevation: 0,
                      value: homeControllor.checkFilter.value,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "All",
                          ),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Income",
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Expanse",
                          ),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        homeControllor.checkFilter.value = value!;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      "${sum}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: homeControllor.checkFilter.value == 0
                  ? FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.hasData) {
                          List<Map>? l1 = snapshot.data;
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  "Income Expanse Tracker",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.sp),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50.sp,
                                      margin: EdgeInsets.all(5.sp),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        // color: Colors.white,
                                        color: l1[index]['incomeExpanse'] == 0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10.sp),
                                          Container(
                                            width: 120,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "title :- ${l1[index]['title']}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "resion :- ${l1[index]['resion']}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 40.sp),
                                          Container(
                                            width: 70.sp,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "price :- ${l1[index]['price']}",
                                            ),
                                          ),
                                          SizedBox(width: 10.sp),
                                          IconButton(
                                            onPressed: () {
                                              HomeModel h1 = HomeModel(
                                                id: l1[index]['id'],
                                                incomeExpanse: l1[index]
                                                    ['incomeExpanse'],
                                                price: l1[index]['price'],
                                                resion: l1[index]['resion'],
                                                title: l1[index]['title'],
                                                checkUpdate: 1,
                                              );
                                              Get.toNamed(
                                                '/addData',
                                                arguments: h1,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              homeControllor.deleteIncome(
                                                  id: l1[index]['id']);
                                              homeControllor.readIncome();
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: l1!.length,
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      future: homeControllor.readIncome(),
                    )
                  : FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.hasData) {
                          List<Map>? l1 = snapshot.data;
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  "Income Expanse Tracker",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.sp),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50.sp,
                                      margin: EdgeInsets.all(5.sp),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        // color: Colors.white,
                                        color: l1[index]['incomeExpanse'] == 0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10.sp),
                                          Container(
                                            width: 120,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "title :- ${l1[index]['title']}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "resion :- ${l1[index]['resion']}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 40.sp),
                                          Container(
                                            width: 70.sp,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "price :- ${l1[index]['price']}",
                                            ),
                                          ),
                                          SizedBox(width: 10.sp),
                                          IconButton(
                                            onPressed: () {
                                              HomeModel h1 = HomeModel(
                                                id: l1[index]['id'],
                                                incomeExpanse: l1[index]
                                                    ['incomeExpanse'],
                                                price: l1[index]['price'],
                                                resion: l1[index]['resion'],
                                                title: l1[index]['title'],
                                                checkUpdate: 1,
                                              );
                                              Get.toNamed(
                                                '/addData',
                                                arguments: h1,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              homeControllor.deleteIncome(
                                                  id: l1[index]['id']);
                                              homeControllor.readIncome();
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: l1!.length,
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      future: homeControllor.filterData(
                          status: homeControllor.checkFilter.value),
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            HomeModel h1 = HomeModel(
              checkUpdate: 0,
            );
            Get.toNamed(
              '/addData',
              arguments: h1,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    setState(() {});
  }
}
