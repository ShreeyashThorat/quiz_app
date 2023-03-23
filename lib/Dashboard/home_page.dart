import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Auth%20Screens/login.dart';
import 'package:quiz_app/Dashboard/quiz.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onTap: () => exit(0)),
        title: const Text(
          'Hi There...!',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Do you want to exit this application?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.orange, fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginScreen()),
                        );
                      });
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.orange, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const Image(
              width: double.infinity, image: AssetImage("assets/quiz.png")),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('uid', isEqualTo: uid)
                  .snapshots(),
              builder:
                  (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ],
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: 200,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 112, 131, 253),
                                Color.fromARGB(255, 202, 209, 255),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "BEST SCORE",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 75,
                              height: 75,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(180)),
                              child: Text(
                                "00",
                                style: GoogleFonts.righteous(
                                    color: Colors.brown.shade400,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: 200,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 248, 212, 102),
                                Color.fromARGB(255, 250, 236, 195),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "LAST SCORE",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 75,
                              height: 75,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(180)),
                              child: Text(
                                "00",
                                style: GoogleFonts.righteous(
                                    color: Colors.brown.shade400,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  var data = snapshot.data!.docs[0];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: 200,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 112, 131, 253),
                                Color.fromARGB(255, 202, 209, 255),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "BEST SCORE",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(180)),
                              child: Text(
                                "${data['Best Score']}",
                                style: GoogleFonts.righteous(
                                    color: Colors.brown.shade400,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: 200,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 248, 212, 102),
                                Color.fromARGB(255, 250, 236, 195),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "LAST SCORE",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(180)),
                              child: Text(
                                "${data['Last Score']}",
                                style: GoogleFonts.righteous(
                                    color: Colors.brown.shade400,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
          const SizedBox(
            height: 60,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text(
              "START A NEW QUIZ, ",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text(
              "There will be a total 20 questions, similarly each question will have a time limit of 60 seconds",
              style: TextStyle(fontSize: 17, color: Colors.black54),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5.0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Start A Quiz',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
