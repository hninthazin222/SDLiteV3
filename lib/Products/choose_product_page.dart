import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sdlite/Models/product_models.dart';
import 'package:sdlite/Widgets/search_box_textfield.dart';
import 'package:sdlite/common.dart';
import 'package:sdlite/style.dart';

class ChooseProductPage extends StatefulWidget {
  final List<ProductListModel> selectedproductlist;
  const ChooseProductPage({super.key, required this.selectedproductlist});

  @override
  State<ChooseProductPage> createState() => _ChooseProductPageState();
}

class _ChooseProductPageState extends State<ChooseProductPage> {
  final TextEditingController _searchController = TextEditingController();
  bool getProduct = false;
  List<ProductListModel> productlist = [];
  List<ProductListModel> selectproductlist = [];
  int pageSize = 20;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appbarStyle(
          context,
          'Products',
          null,
          [
            IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context, null);
                });
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
          PreferredSize(
            preferredSize: const Size.fromHeight(
              50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: SearchBoxTextField(
                    controller: _searchController,
                    hintText: "Search products",
                    onPressed: () {
                      setState(() {
                        getProductList();
                      });
                    },
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 10),
                    keyboardType: TextInputType.text,
                    borderColor: Colors.grey[300]!,
                    borderWidth: 1.0,
                    onChanged: (value) {},
                    inputFormatters: [],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, null);
            setState(() {});
            return false;
          },
          child: getProduct == true
              ? const SpinKitRing(
                  size: 40,
                  color: Colors.black,
                  lineWidth: 3,
                )
              : productlist.isEmpty
                  ? Center(
                      child: Text(
                        'Empty',
                        style: TextStyle(
                          fontFamily: fontRoboto,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //// product list
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: productlist.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        for (var i = 0;
                                            i < selectproductlist.length;
                                            i++) {
                                          if (productlist[index].id ==
                                              selectproductlist[i].id) {
                                            selectproductlist.removeAt(i);
                                          }
                                        }
                                        if (productlist[index].check == true) {
                                          productlist[index].check = false;
                                        } else {
                                          productlist[index].check = true;
                                          selectproductlist
                                              .add(productlist[index]);
                                        }
                                        setState(() {
                                          print(selectproductlist.length);
                                        });
                                      },
                                      child: Container(
                                        color: const Color(0xFFFFFFFF),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 8, 16, 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 24,
                                                height: 24,
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: Checkbox(
                                                  activeColor: mainColor,
                                                  checkColor: Colors.white,
                                                  value:
                                                      productlist[index].check,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      // productlist[index].check = productlist[index].check;
                                                      if (productlist[index]
                                                              .check ==
                                                          true) {
                                                        productlist[index]
                                                            .check = false;
                                                        selectproductlist
                                                            .remove(productlist[
                                                                index]);
                                                      } else {
                                                        productlist[index]
                                                            .check = true;
                                                        selectproductlist.add(
                                                            productlist[index]);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      productlist[index]
                                                          .code
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: fontRoboto,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xFF374151),
                                                      ),
                                                    ),
                                                    Text(
                                                      productlist[index]
                                                          .desc
                                                          .toString(),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              fontRoboto,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "On Hand: ${productlist[index].onhand}",
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                fontRoboto,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 5,
                                                          width: 5,
                                                          color: const Color(
                                                              0xFFD1D5DB),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8,
                                                                  right: 8),
                                                        ),
                                                        Text(
                                                          productlist[index]
                                                              .amount,
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                fontRoboto,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
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
                                    ),
                                    Container(
                                      height: 1,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context, selectproductlist);
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Confirm",
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
      ),
    );
  }

  getProductList() {
    setState(() {
      getProduct = true;
    });
    productlist.add(
      ProductListModel(
        id: 1,
        syskey: '1',
        code: '000001',
        desc: 'Item',
        onhand: '0.0',
        amount: '2500',
        qty: '1',
        qtyTotalAmt: '2500',
        check: false,
      ),
    );
    productlist.add(
      ProductListModel(
        id: 2,
        syskey: '2',
        code: '000002',
        desc: 'Item2',
        onhand: '0.0',
        amount: '1000',
        qty: '1',
        qtyTotalAmt: '1000',
        check: false,
      ),
    );
    getselectedData();
    setState(() {
      getProduct = false;
    });
  }

  getselectedData() {
    setState(() {
      selectproductlist = widget.selectedproductlist;
      if (selectproductlist.isNotEmpty && productlist.isNotEmpty) {
        for (var i = 0; i < productlist.length; i++) {
          for (var a = 0; a < selectproductlist.length; a++) {
            if (productlist[i].syskey == selectproductlist[a].syskey) {
              productlist[i].id = selectproductlist[a].id;
              productlist[i].syskey = selectproductlist[a].syskey;
              productlist[i].code = selectproductlist[a].code;
              productlist[i].desc = selectproductlist[a].desc;
              productlist[i].onhand = selectproductlist[a].onhand;
              productlist[i].amount = selectproductlist[a].amount;
              productlist[i].qty = selectproductlist[a].qty;
              productlist[i].qtyTotalAmt = selectproductlist[a].qtyTotalAmt;
              print(selectproductlist[a].qtyTotalAmt);
              print(productlist[i].qtyTotalAmt);
              productlist[i].check = true;
            }
          }
        }
      }
    });
  }
}
