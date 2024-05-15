import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sdlite/Customers/choose_customer_page.dart';
import 'package:sdlite/Models/product_models.dart';
import 'package:sdlite/Products/choose_product_page.dart';
import 'package:sdlite/Products/product_details_page.dart';
import 'package:sdlite/SO/solist_page.dart';
import 'package:sdlite/common.dart';
import 'package:sdlite/style.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddSOPage extends StatefulWidget {
  const AddSOPage({super.key});

  @override
  State<AddSOPage> createState() => _AddSOPageState();
}

class _AddSOPageState extends State<AddSOPage> {
  //// date
  String salesDate = "";
  //// customer
  String customerid = '';
  String customersyskey = "";
  String customerName = "";
  String customerCode = "";
  String currency = "";
  //// remark
  final TextEditingController _remarkController = TextEditingController();
  //// product
  List<ProductListModel> selectedproductlist = [];
  var productdetail = {};
  //// bottom navigation bar
  bool isShow = false;
  // price
  String subTotal = "0.00";
  String discount = "0.00";
  String taxAmt = "0.00";
  String totalAmt = "0.00";

  @override
  void initState() {
    setState(() {
      binedNewData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appbarStyle(
        context,
        "TBA",
        GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Color(0xFF1D1F1F),
          ),
          onTap: () {
            setState(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SOListPage(),
                ),
              );
            });
          },
        ),
        [Container()],
        PreferredSize(
          preferredSize: const Size.fromHeight(
            0,
          ),
          child: Container(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SOListPage(),
            ),
          );
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // userdata
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // date
                    Container(
                      color: Colors.white,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            salesDate,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: fontRoboto,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.edit,
                              color: mainColor,
                              size: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // customer
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          chooseCustomer();
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customerName != ""
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    child: Text(
                                      "Customer",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: fontRoboto,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                            customerName == ""
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              customerName == ""
                                                  ? 'Customer Name'
                                                  : customerName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const Text(
                                              "Currency",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              customerCode == ""
                                                  ? 'Customer Code'
                                                  : customerCode,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                            Text(
                                              currency,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // product
              Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Products",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: fontRoboto,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "assets/images/icons/scan.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            selectedproductlist.isEmpty
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          chooseProduct();
                                        });
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    selectedproductlist.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                if (customerName != "") {
                                  chooseProduct();
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              // width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              margin: const EdgeInsets.only(top: 10),
                              child: Center(
                                child: Text(
                                  "+ Add Products",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: mainColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: fontRoboto,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: selectedproductlist.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await chooseProductDetails(
                                      selectedproductlist[index], index);
                                  calculateTotal();
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  // margin: EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            color: Colors.transparent,
                                            child: Text(
                                              selectedproductlist[index]
                                                  .desc
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: fontRoboto,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              selectedproductlist[index]
                                                          .qtyTotalAmt ==
                                                      ""
                                                  ? "0.00"
                                                  : selectedproductlist[index]
                                                      .qtyTotalAmt,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontFamily: fontRoboto,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            selectedproductlist[index].amount,
                                            style: TextStyle(
                                              fontFamily: fontRoboto,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        height: 1,
                                        color: const Color(0xFFE5E7EB),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
              // remark
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Remark",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontRoboto,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextField(
                      controller: _remarkController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: isShow ? 210 : 150,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isShow) {
                        isShow = false;
                      } else {
                        isShow = true;
                      }
                    });
                  },
                  child: Icon(
                    isShow
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_up_outlined,
                    size: 45,
                  ),
                ),
              ],
            ),
            //// show
            isShow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Total",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontRoboto,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFF051320),
                              ),
                            ),
                            Text(
                              subTotal,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontRoboto,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFF051320),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontRoboto,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFF051320),
                              ),
                            ),
                            Text(
                              discount,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontRoboto,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFF051320),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontRoboto,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFF051320),
                              ),
                            ),
                            Text(
                              taxAmt,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontRoboto,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFF051320),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
            ////
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Total",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: fontRoboto,
                      fontSize: 16,
                      color: const Color(0xFF051320),
                    ),
                  ),
                  Text(
                    totalAmt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF051320),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontFamily: fontRoboto,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //// function
  binedNewData() async {
    salesDate = dateformat.format(DateTime.now());
    productdetail = {
      'qty': '1',
      'total': '0.00',
    };
    setState(() {});
  }

  chooseCustomer() async {
    final data = await showCupertinoModalBottomSheet(
      enableDrag: false,
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ChooseCustomerPage(),
    );

    if (data != null) {
      var decodeddata = jsonDecode(data);
      customerid = decodeddata["customercode"];
      customersyskey = decodeddata["customercode"];
      customerCode = decodeddata["customercode"];
      customerName = decodeddata["customername"];
      currency = decodeddata["currency"];
    }
    setState(() {});
  }

  chooseProduct() async {
    final data = await showCupertinoModalBottomSheet(
      enableDrag: false,
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ChooseProductPage(
        selectedproductlist: selectedproductlist,
      ),
    );

    if (data != null) {
      selectedproductlist = data;
    }

    setState(() {
      calculateTotal();
    });
  }

  chooseProductDetails(item, index) async {
    productdetail["qty"] = '${item.qty}';
    productdetail["total"] = '${item.qtyTotalAmt}';
    final data = await showCupertinoModalBottomSheet(
      enableDrag: false,
      expand: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailsPage(
        selectedproduct: item,
        data: jsonEncode(productdetail),
      ),
    );

    if (data != null) {
      ////
      productdetail = jsonDecode(data);
      double total =
          double.parse(selectedproductlist[index].amount.toString()) *
              double.parse(productdetail["qty"].toString());
      selectedproductlist[index].qtyTotalAmt = total.toString();
      selectedproductlist[index].qty = productdetail["qty"].toString();
      ////
      subTotal = "0.00";
      double sub = 0.0;
      for (var i = 0; i < selectedproductlist.length; i++) {
        sub = sub + double.parse(selectedproductlist[i].qtyTotalAmt.toString());
      }
      subTotal = sub.toString();
    }
    setState(() {});
  }

  calculateTotal() {
    subTotal = "0.00";
    discount = "0.00";
    totalAmt = "0.00";
    for (var i = 0; i < selectedproductlist.length; i++) {
      subTotal =
          "${double.parse(subTotal.toString()) + double.parse(selectedproductlist[i].amount.toString()) * double.parse(selectedproductlist[i].qty.toString())}";
    }
    totalAmt =
        (double.parse(subTotal.toString()) - double.parse(discount.toString()))
            .toString();
    setState(() {});
  }
}
