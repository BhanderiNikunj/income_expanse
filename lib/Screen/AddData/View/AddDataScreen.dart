import 'package:api_exam/Screen/AddData/Controllor/AddDataControllor.dart';
import 'package:api_exam/Screen/Home/Model/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  AddDataControllor addDataControllor = Get.put(
    AddDataControllor(),
  );

  HomeModel h1 = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (h1.checkUpdate == 1) {
      addDataControllor.txtTitle = TextEditingController(text: "${h1.title}");
      addDataControllor.txtPrice = TextEditingController(text: "${h1.price}");
      addDataControllor.txtResion = TextEditingController(text: "${h1.resion}");
      addDataControllor.checkIncome.value = h1.incomeExpanse!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              Center(
                child: Text(
                  "",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              TextField(
                controller: addDataControllor.txtTitle,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  label: Text("Enter your task"),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              TextField(
                controller: addDataControllor.txtResion,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  label: Text("Enter your resion"),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              TextField(
                controller: addDataControllor.txtPrice,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  label: Text("Enter your Price"),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              Obx(
                () => DropdownButton(
                  dropdownColor: Colors.black,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  isExpanded: true,
                  elevation: 0,
                  value: addDataControllor.checkIncome.value,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "Income",
                      ),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Expanse",
                      ),
                      value: 1,
                    ),
                  ],
                  onChanged: (value) {
                    addDataControllor.checkIncome.value = value!;
                  },
                ),
              ),
              SizedBox(height: 20.sp),
              InkWell(
                onTap: () {
                  // print(addDataControllor.txtTitle.text);
                  // print(addDataControllor.txtResion.text);
                  // print(addDataControllor.txtPrice.text);
                  // print(addDataControllor.checkIncome.value);

                  if (h1.checkUpdate == 1) {
                    addDataControllor.updateIncome(
                      title: addDataControllor.txtTitle.text,
                      resion: addDataControllor.txtResion.text,
                      price: addDataControllor.txtPrice.text,
                      incomeExpanse: addDataControllor.checkIncome.value,
                      id: h1.id,
                    );

                    addDataControllor.readIncome();

                    Get.back();

                    Get.snackbar(
                      "success",
                      "",
                    );
                  } else {
                    addDataControllor.addIncomeExpanse(
                      title: addDataControllor.txtTitle.text,
                      resion: addDataControllor.txtResion.text,
                      price: addDataControllor.txtPrice.text,
                      incomeExpanse: addDataControllor.checkIncome.value,
                    );

                    addDataControllor.readIncome();

                    Get.back();

                    Get.snackbar(
                      "success",
                      "",
                    );
                  }
                },
                child: Container(
                  height: 30.sp,
                  width: 60.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    h1.checkUpdate == 1 ? "Update" : "Submit",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
