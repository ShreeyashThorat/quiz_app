import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Auth%20Screens/login.dart';
import 'package:quiz_app/Dashboard/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool showPassword = false;
  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "SIGN",
                            style: GoogleFonts.righteous(
                                fontSize: 50,
                                color: const Color(0xff2A40CE),
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " UP",
                            style: GoogleFonts.righteous(
                                fontSize: 50,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Color(0xff2A40CE)),
                      ),
                      hintText: "E-mail Address",
                      prefixStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(12),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: const Color(0xff2A40CE),
                    cursorHeight: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: TextField(
                    controller: pass,
                    keyboardType: TextInputType.text,
                    obscureText: !showPassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Color(0xff2A40CE)),
                        ),
                        hintText: "Password",
                        isDense: true, // Added this
                        contentPadding: const EdgeInsets.all(12),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: showPassword
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                    size: 20,
                                  ))),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    cursorColor: const Color(0xff2A40CE),
                    cursorHeight: 20,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff2A40CE)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: signup,
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Please Wait...',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ))
                            ],
                          )
                        : const Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            color: const Color.fromARGB(10, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hi there...!",
                      style: TextStyle(color: Colors.black38),
                    ),
                    Text(
                      "Already have an account ?",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0.0),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side:
                                  const BorderSide(color: Color(0xff2A40CE))))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xff2A40CE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  signup() async {
    String emailId = email.text;
    String password = pass.text;
    if (emailId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your details')));
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailId)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please valid email id')));
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailId,
          password: password,
        )
            .then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$emailId Successfully Registered')));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('The password provided is too weak.')));
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('The account already exists for that email.')));
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error Occurred')));
      }
    }
  }
}
