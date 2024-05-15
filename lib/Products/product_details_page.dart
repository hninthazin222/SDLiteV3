import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sdlite/Models/product_models.dart';
import 'package:sdlite/common.dart';
import 'package:sdlite/style.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductListModel selectedproduct;
  final String data;
  const ProductDetailsPage({
    super.key,
    required this.selectedproduct,
    required this.data,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductListModel? item;
  int qty = 1;

  @override
  void initState() {
    super.initState();
    getdetailsdata();
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
          'Product Details',
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
              0,
            ),
            child: Container(),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            setState(() {
              Navigator.pop(context, null);
            });
            return false;
          },
          child: item == null
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: const Color(0xFFFFFFFF),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item!.code.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: fontRoboto,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF374151),
                                ),
                              ),
                              Text(
                                item!.desc.toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: fontRoboto,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (qty > 1) {
                                  qty = qty - 1;
                                  item!.qtyTotalAmt =
                                      "${double.parse(item!.amount) * qty}";
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: 110,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: mainColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "$qty",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: fontRoboto,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                qty = qty + 1;
                                item!.qtyTotalAmt =
                                    "${double.parse(item!.amount) * qty}";
                                setState(() {});
                              },
                              child: Container(
                                width: 110,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pricing",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: fontRoboto,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            priceCard("Unit Price", item!.amount),
                            priceCard("Discount", "0%"),
                            priceCard("Unit discount", "0%"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: fontRoboto,
                                    color: const Color(0xFF1D1F1F),
                                  ),
                                ),
                                Text(
                                  item!.qtyTotalAmt,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: fontRoboto,
                                    color: const Color(0xFF1D1F1F),
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
        bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () {
              setState(() {
                var data = {
                  'qty': "$qty",
                  'total': item!.qtyTotalAmt,
                };
                Navigator.pop(context, jsonEncode(data));
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
                  "Done",
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

  priceCard(title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: fontRoboto,
            color: const Color(0xFF1D1F1F),
          ),
        ),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: fontRoboto,
            color: const Color(0xFF1D1F1F),
          ),
        ),
      ],
    );
  }

  getdetailsdata() {
    setState(() {
      item = widget.selectedproduct;
      var data = jsonDecode(widget.data);
      item!.qtyTotalAmt = data["total"].toString();
      qty = int.parse(data["qty"].toString());
    });
  }
}
