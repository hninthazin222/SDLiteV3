import 'package:flutter/material.dart';
import 'package:sdlite/Home/tabs_page.dart';
import 'package:sdlite/Models/so_models.dart';
import 'package:sdlite/SO/add_so_page.dart';
import 'package:sdlite/common.dart';
import 'package:sdlite/style.dart';

class SOListPage extends StatefulWidget {
  const SOListPage({super.key});

  @override
  State<SOListPage> createState() => _SOListPageState();
}

class _SOListPageState extends State<SOListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SOListModel> soList = [];

  @override
  void initState() {
    getSOList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appbarStyle(
        context,
        "Orders",
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
                  builder: (context) => const TabsPage(
                    currentIndex: 0,
                  ),
                ),
              );
            });
          },
        ),
        [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSOPage(),
                  ),
                );
              });
            },
            icon: Icon(
              Icons.add,
              color: mainColor,
            ),
          ),
        ],
        PreferredSize(
          preferredSize: const Size.fromHeight(
            100,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  color: Colors.transparent,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                        color: Color(0xFF6B7280),
                      ),
                      hintText: "Search orders",
                      hintStyle: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: const Color(0xFFF3F4F6),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color.fromRGBO(229, 231, 235, 1.0),
                          ),
                        ),
                        child: Image.asset(
                          "assets/images/icons/sliders.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TabsPage(currentIndex: 0),
            ),
          );
          return false;
        },
        child: soList.isEmpty
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
                    ListView.builder(
                      itemCount: soList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                              padding: const EdgeInsets.only(
                                  top: 6, bottom: 6, left: 16, right: 16),
                              child: Text(
                                soList[index].date,
                                style: TextStyle(
                                  color: const Color(0xFF6B7280),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: fontRoboto,
                                ),
                              ),
                            ),
                            ListView.builder(
                              itemCount: soList[index].datalist.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                var data = soList[index].datalist;
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "#${data[i]["code"]}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: fontRoboto,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${data[i]["description"]}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: fontRoboto,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            "${data[i]["customername"]}",
                                            style: TextStyle(
                                              color: const Color(0xFF6B7280),
                                              fontFamily: fontRoboto,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          statusCard(data[i]['status']),
                                          const SizedBox(
                                            height: 13,
                                          ),
                                          Text(
                                            "${data[i]["currency"]} ${data[i]["amount"]}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: fontRoboto,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  List mainList = [
    {
      'id': 1,
      'date': 'May 7',
      'datalist': [
        {
          'id': 1,
          'code': '00111',
          'description': 'SO-000001',
          'customername': 'Htet Oo Ko',
          'currency': "MMK",
          'amount': '100,000',
          'status': 1,
        },
        {
          'id': 2,
          'code': '00112',
          'description': 'SO-000002',
          'customername': 'Htet Oo Ko',
          'currency': "MMK",
          'amount': '10,000',
          'status': 2,
        },
        {
          'id': 3,
          'code': '00113',
          'description': 'SO-000003',
          'customername': 'Htet Oo Ko',
          'currency': "USD",
          'amount': '150,000',
          'status': 3,
        },
      ],
    },
    {
      'id': 2,
      'date': 'May 8',
      'datalist': [
        {
          'id': 1,
          'code': '00111',
          'description': 'SO-000001',
          'customername': 'Htet Oo Ko',
          'currency': "MMK",
          'amount': '100,000',
          'status': 1,
        },
        {
          'id': 2,
          'code': '00112',
          'description': 'SO-000002',
          'customername': 'Htet Oo Ko',
          'currency': "MMK",
          'amount': '10,000',
          'status': 2,
        },
      ],
    },
  ];

  //// function
  getSOList() {
    soList = [];
    for (var i = 0; i < mainList.length; i++) {
      soList.add(
        SOListModel(
          id: mainList[i]['id'],
          date: mainList[i]['date'],
          datalist: mainList[i]['datalist'],
        ),
      );
    }
    setState(() {});
  }

  statusCard(status) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: status == 1
            ? const Color.fromRGBO(51, 160, 49, 0.12156862745098039)
            : status == 2
                ? const Color.fromRGBO(59, 130, 246, 0.12156862745098039)
                : status == 3
                    ? const Color.fromRGBO(247, 127, 0, 0.12156862745098039)
                    : const Color.fromRGBO(51, 160, 49, 0.12156862745098039),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: status == 1
                ? const Color(0xFF33A031)
                : status == 2
                    ? const Color(0xFF3B82F6)
                    : status == 3
                        ? mainColor
                        : const Color(0xFF33A031),
            size: 10,
          ),
          Text(
            status == 1
                ? " Completed"
                : status == 2
                    ? " Saved"
                    : status == 3
                        ? " Converted"
                        : " Completed",
            style: TextStyle(
              color: status == 1
                  ? const Color(0xFF33A031)
                  : status == 2
                      ? const Color(0xFF3B82F6)
                      : status == 3
                          ? mainColor
                          : const Color(0xFF33A031),
              fontFamily: fontRoboto,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
