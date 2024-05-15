import 'package:flutter/material.dart';
import 'package:sdlite/Home/tabs_page.dart';
import 'package:sdlite/style.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _signincontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: Text(
                      "Login with mobile number.",
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: fontInter,
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 15),
                    child: Text(
                      "Enter your phone number to login to your store.",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: fontRoboto,
                        color: const Color(0xFF374151),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: TextField(
                      controller: _signincontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Mobile Number",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF1D1F1F),
                          fontWeight: FontWeight.w400,
                          fontFamily: fontInter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: fontRoboto,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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
}
