import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/global.dart';
import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Otp extends StatefulWidget {
  static String routeName = 'Otp';
  final String otp;
  const Otp({Key? key, required this.otp}) : super(key: key);
  // const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the screen width to set responsive padding
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFCE00),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: screenWidth > 600 ? screenWidth * 0.1 : 16,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/lekhone_512X512.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFCE00),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _textFieldOTP(controller: otpController1),
                    _textFieldOTP(controller: otpController2),
                    _textFieldOTP(controller: otpController3),
                    _textFieldOTP(controller: otpController4),
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Combine the OTP from individual controllers
                    String enteredOTP =
                        "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";

                    // Replace the following logic with your verification logic
                    if (enteredOTP == widget.otp) {
                      print("Received OTP: ${widget.otp}");
                      print("Entered OTP: ${enteredOTP}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login successful'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const HomeScreen(),
                      //   ),
                      // );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const App(),
                      //   ),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrackerApp(),
                        ),
                      );
                      print("OTP Verified");
                    } else {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color.fromARGB(0, 236, 232, 232),
                        content: AwesomeSnackbarContent(
                          title: 'Oh know !',
                          message: 'Incorrect OTP',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => LoginScreen(),
                      //   ),
                      // );
                      print("Incorrect OTP");
                    }
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Verify',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Combine the OTP from individual controllers
              //       String enteredOTP =
              //           "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";

              //       // Replace the following logic with your verification logic
              //       if (enteredOTP == "1234") {
              //         print("OTP Verified"); // Replace with your logic
              //       } else {
              //         print("Incorrect OTP"); // Replace with your logic
              //       }
              //     },
              //     style: ButtonStyle(
              //       foregroundColor:
              //           MaterialStateProperty.all<Color>(Colors.white),
              //       backgroundColor:
              //           MaterialStateProperty.all<Color>(Colors.purple),
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(24.0),
              //         ),
              //       ),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.all(14.0),
              //       child: Text(
              //         'Verify',
              //         style: TextStyle(fontSize: 16),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              // sendOTP(phoneNumberController.text, '+91');
              GestureDetector(
                onTap: () {
                  sendOTP(context, phoneNumberController.text, '+91');
                  // sendOTP(phoneNumberController.text, '+91');
                },
                child: Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 253, 253, 253),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Text(
              //   "Resend New Code",
              //   style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //       color: Color.fromARGB(255, 11, 121, 68)
              //       // color: Colors.purple,
              //       ),
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required TextEditingController controller}) {
    return Container(
      width: 50, // Adjust the width as needed
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            contentPadding:
                EdgeInsets.zero, // Added this line to remove extra padding
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
