import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sdlite/Models/customer_models.dart';
import 'package:sdlite/Widgets/search_box_textfield.dart';
import 'package:sdlite/common.dart';
import 'package:sdlite/style.dart';

class ChooseCustomerPage extends StatefulWidget {
  const ChooseCustomerPage({super.key});

  @override
  State<ChooseCustomerPage> createState() => _ChooseCustomerPageState();
}

class _ChooseCustomerPageState extends State<ChooseCustomerPage> {
  final TextEditingController _searchController = TextEditingController();
  int pageSize = 20;
  //// customer
  bool getCustomer = false;
  List<CustListModel> custlist = [];

  @override
  void initState() {
    getCustomerList();
    super.initState();
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
          'Customers',
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
                    hintText: "Search customers",
                    onPressed: () {
                      setState(() {
                        getCustomerList();
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
          child: getCustomer == true
              ? const SpinKitRing(
                  size: 40,
                  color: Colors.black,
                  lineWidth: 3,
                )
              : custlist.isEmpty
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
                          //// customer list
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: custlist.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // var data = {
                                        //   "customerid": custlist[index]["id"],
                                        //   "customersyskey": custlist[index]["syskey"],
                                        //   "customercode": custlist[index]["t2"],
                                        //   "customername": custlist[index]["t1"],
                                        //   "currency": custlist[index]["t4"],
                                        // };
                                        var data = {
                                          "customerid": custlist[index].id,
                                          "customersyskey":
                                              custlist[index].customersyskey,
                                          "customercode":
                                              custlist[index].customercode,
                                          "customername":
                                              custlist[index].customername,
                                          "currency": custlist[index].currency,
                                          "address": custlist[index].address,
                                        };
                                        setState(() {
                                          Navigator.pop(
                                              context, jsonEncode(data));
                                        });
                                      },
                                      child: Container(
                                        color: const Color(0xFFFFFFFF),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 8, 16, 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    custlist[index]
                                                                .customername ==
                                                            ""
                                                        ? 'Customer Name'
                                                        : custlist[index]
                                                            .customername,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontRoboto,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "(${custlist[index].currency})",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontRoboto,
                                                      color: const Color(
                                                          0xFF374151),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    custlist[index]
                                                                .customercode ==
                                                            ""
                                                        ? 'Customer Code'
                                                        : custlist[index]
                                                            .customercode,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontRoboto,
                                                      color: const Color(
                                                          0xFF374151),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    custlist[index].address,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontRoboto,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
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
      ),
    );
  }

  //// function
  getCustomerList() {
    setState(() {
      getCustomer = true;
    });
    custlist.add(
      CustListModel(
        id: 1,
        customersyskey: '1',
        customercode: 'D-002',
        customername: 'Htet Oo Ko',
        currency: 'MMK',
        address: 'Mandalay',
      ),
    );
    setState(() {
      getCustomer = false;
    });
  }
}
