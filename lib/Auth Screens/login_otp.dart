import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Auth%20Screens/login.dart';
import 'package:quiz_app/Dashboard/home_page.dart';

class LoginOTP extends StatefulWidget {
  final String phoneNo;
  const LoginOTP({super.key, required this.phoneNo});

  @override
  State<LoginOTP> createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {
  var otpval = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2A40CE),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            height: MediaQuery.of(context).size.height / 2,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Phone Verification",
                  style:
                      GoogleFonts.righteous(fontSize: 35, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                    "Please enter the OTP sent to your mobile number ${widget.phoneNo}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100.0),
              ),
            ),
            height: MediaQuery.of(context).size.height / 2,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: OtpTextField(
                      margin: const EdgeInsets.all(8),
                      cursorColor: Colors.black,
                      mainAxisAlignment: MainAxisAlignment.center,
                      numberOfFields: 6,
                      fillColor: Colors.black12,
                      filled: true,
                      textStyle: const TextStyle(
                        fontSize: 22,
                      ),
                      showFieldAsBox: false,
                      focusedBorderColor: Colors.black12,
                      onCodeChanged: (value) {},
                      onSubmit: (code) async {
                        otpval = code;
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: LoginScreen.verify,
                                  smsCode: otpval);

                          // Sign the user in (or link) with the credential
                          await FirebaseAuth.instance
                              .signInWithCredential(credential)
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (Route<dynamic> route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('OTP Verified')));
                          });
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Wrong OTP')));
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "Didn't recieve an OTP ?",
                  style: TextStyle(fontSize: 15, color: Colors.black38),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(15, 5, 20, 0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Resend OTP',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
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
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: LoginScreen.verify,
                                smsCode: otpval);
                        await FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('OTP Verified')));
                        });
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Wrong OTP')));
                      }
                    },
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
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
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
}
