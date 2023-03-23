import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/Auth%20Screens/login_otp.dart';
import 'package:quiz_app/Auth%20Screens/signup.dart';
import 'package:quiz_app/Dashboard/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userEmail = "";
  bool showPassword = false;
  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController contrycode = TextEditingController();

  @override
  void initState() {
    contrycode.text = "+91";
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    contact.dispose();
    contrycode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                            text: "LOG",
                            style: GoogleFonts.righteous(
                                fontSize: 50,
                                color: const Color(0xff2A40CE),
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "iN",
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
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.fromLTRB(15, 5, 20, 0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Forgot Password?',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xff2A40CE),
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff2A40CE)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: signInWithEmailAndPassword,
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
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.black26,
                        height: 1.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      const Text("OR"),
                      Container(
                        color: Colors.black26,
                        height: 1.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Login with OTP',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff2A40CE),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _scaffoldKey.currentState
                                  ?.showBottomSheet(
                                      (context) => loginWithOTP(context))),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5.0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: () {
                      signInWithGoogle();
                    },
                    child: isLoading2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Please Wait...',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  ))
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(image: AssetImage("assets/google.png")),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
                      "New here?",
                      style: TextStyle(color: Colors.black38),
                    ),
                    Text(
                      "Create An Account",
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
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    'SIGN UP',
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

  Container loginWithOTP(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text(
              "Login with OTP",
              style: TextStyle(fontSize: 25),
            ),
            trailing: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_sharp)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: contact,
              autofocus: true,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Color(0xff2A40CE)),
                ),
                hintText: "Contact No",
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(15),
              ),
              style: const TextStyle(fontSize: 20, color: Colors.black),
              cursorColor: Colors.grey,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff2A40CE)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ))),
              onPressed: loginViaOTP,
              child: isLoading1
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
                      'GET OTP',
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
    );
  }

  signInWithEmailAndPassword() async {
    String emailId = email.text;
    String password = pass.text;
    if (emailId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your details')));
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emailId, password: password)
            .then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully Logged in')));
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No user found for that email.')));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Wrong password provided for that user.')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error : $e')));
      }
    }
  }

  loginViaOTP() async {
    String contactNo = contact.text;
    if (contactNo.isEmpty || contactNo.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid contact no')));
    } else {
      setState(() {
        isLoading1 = true;
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: contrycode.text + contactNo,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            isLoading1 = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$e')));
        },
        codeSent: (String verificationId, int? resendToken) {
          String phone = contrycode.text + contactNo;
          LoginScreen.verify = verificationId;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginOTP(phoneNo: phone)),
              (Route<dynamic> route) => false);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('OTP has been sent')));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      setState(() {
        isLoading2 = true;
      });
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      userEmail = googleUser.email;

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully Logged in')));
      });
    } catch (e) {
      setState(() {
        isLoading2 = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error : $e')));
    }
  }
}
