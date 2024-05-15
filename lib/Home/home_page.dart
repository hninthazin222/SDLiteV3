import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sdlite/SO/solist_page.dart';
import 'package:sdlite/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //// common
  var homepadding =
      const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12);
  //// header
  String username = '';
  String deviceid = '';
  //// daily overview
  String updatedTime = "";
  String sales = "0 Orders";
  String delivery = "0 Orders";
  String invoices = "0 Invoices";
  double totalSales = 0.0;
  double totalDelivery = 0.0;
  double totalInvoices = 0.0;
  //// customer details
  int customercount = 0;
  int stockcount = 0;
  String customername = '';
  //// tesk
  int tesk = 0;
  //// service
  List servicecard = [
    {
      'name': 'Order',
      'icon': "assets/images/home/order.png",
      'page': 'Order()',
    },
    {
      'name': 'Delivery',
      'icon': "assets/images/home/delivery.png",
      'page': 'Delivery()',
    },
    {
      'name': 'Invoice',
      'icon': "assets/images/home/invoice.png",
      'page': 'Invoice()',
    },
    {
      'name': 'Quick sales',
      'icon': "assets/images/home/quicksales.png",
      'page': 'QuickSales()',
    },
    {
      'name': 'Return',
      'icon': "assets/images/home/return.png",
      'page': 'Return()',
    },
    {
      'name': 'Receipt',
      'icon': "assets/images/home/receipt.png",
      'page': 'Receipt()',
    },
  ];

  @override
  void initState() {
    getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: fontRoboto,
                    color: Colors.black,
                  ),
                ),
                Text(
                  deviceid,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xFF6B7280),
                    fontFamily: fontRoboto,
                  ),
                ),
              ],
            ),
            Image.asset(
              "assets/images/icons/scan.png",
              width: 19.5,
              height: 16.5,
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //// daily overview
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                padding: homepadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Overview",
                      style: headerTextStyle,
                    ),
                    Text(
                      "Updated at $updatedTime",
                      style: titleTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dailyCard("Sales", "$totalSales", sales),
                          dailyCard("Delivery", "$totalDelivery", delivery),
                          dailyCard("Invoices", "$totalInvoices", invoices),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //// current stage
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: homepadding,
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Stage", style: headerTextStyle),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          customerCard(
                            Icons.person,
                            'Customers',
                            '$customercount',
                            const Color(0xFF3B82F6),
                            const Color.fromARGB(24, 59, 131, 246),
                          ),
                          customerCard(
                            Icons.category_rounded,
                            'Stocks',
                            '$stockcount',
                            mainColor,
                            const Color.fromARGB(24, 247, 127, 0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Selected Customer: ',
                                  style: TextStyle(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: fontRoboto,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: customername,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: fontRoboto,
                                        color: const Color(0xFF1D1F1F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //// Service
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: homepadding,
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Services', style: headerTextStyle),
                    GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.only(top: 13),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: List.generate(servicecard.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              getServicePage(servicecard[index]['page']);
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    servicecard[index]['icon'],
                                    width: 48,
                                    height: 48,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${servicecard[index]['name']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontRoboto,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tesks",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: fontRoboto,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'You have ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: fontRoboto,
                        color: const Color(0xFF6B7280),
                      ),
                      children: [
                        TextSpan(
                          text: '$tesk',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: fontRoboto,
                            color: const Color(0xFF1D1F1F),
                          ),
                        ),
                        TextSpan(
                          text: ' task to do.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontRoboto,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.add,
                    color: mainColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //// get function
  getHomeData() {
    binedtestdata();
  }

  binedtestdata() {
    //// appbar
    username = 'Htet Oo Ko';
    deviceid = 'D-0002';
    //// daily overview
    updatedTime = dateformat.format(DateTime.now());
    sales = "13 Orders";
    delivery = "30 Orders";
    invoices = "45 Invoices";
    totalSales = 32.4;
    totalDelivery = 26.4;
    totalInvoices = 109.3;
    //// customer details
    customercount = 339;
    stockcount = 109;
    customername = 'Bok Sone Ma';
    setState(() {});
  }

  //// function
  dailyCard(title, totalvalue, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${totalvalue}K",
          style: TextStyle(
            fontFamily: fontRoboto,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: mainColor,
          ),
        ),
        Text(
          "Total $title",
          style: TextStyle(
            fontFamily: fontRoboto,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF1D1F1F),
          ),
        ),
        Text(
          "$value",
          style: TextStyle(
            fontFamily: fontRoboto,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  customerCard(icon, title, count, iconColor, backgroundiconcolor) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: backgroundiconcolor,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.only(right: 10),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  fontFamily: fontRoboto,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                ),
              ),
              Text(
                "$count",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: fontRoboto,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getServicePage(page) {
    if (page == "Order()") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SOListPage(),
        ),
      );
    }
  }
}
