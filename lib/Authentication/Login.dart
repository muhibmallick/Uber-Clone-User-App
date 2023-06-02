import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Global/global.dart';
import '../SplashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';
import 'SignUp_Screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController EmailTextEditingController = TextEditingController();
  TextEditingController PasswordTextEditingController = TextEditingController();

  validationform() {
    if (!EmailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email is not valid.");
    } else if (PasswordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required");
    } else {
      LoginUserNow();
    }
  }

  LoginUserNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: EmailTextEditingController.text.trim(),
      password: PasswordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error:  " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
     // First we made refrence to the drivers node
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("Users");
      // Then we are searching for the specific id meaning driverkey
      driversRef.child(firebaseUser.uid).once().then((driverKey)
      {
        // storing the drivers key in snap variable
        final snap = driverKey.snapshot;
        // checking if the variable is null or not if it is execute else statement otherwise if statement
        if(snap.value != null)
        {
          
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error accurred during login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/logo.png"),
              ),
              const Text(
                "Login as User",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //**************Text Field 1 *************
              TextField(
                controller: EmailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ), //********Textfield END**********
              //**************Text Field 2 *************
              TextField(
                controller: PasswordTextEditingController,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              //********Textfield END**********
              //********Sizebox**********
              const SizedBox(
                height: 20,
              ),
//*****************Elevatedbutton****************
              ElevatedButton(
                onPressed: () {
                  validationform();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => CarInfoScreen())));
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightGreenAccent),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 40, right: 40),
              //   child: Row(
              //     children: [
              //       const Text(
              //         "Don't have an Account ?",
              //         style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 18,
              //           // fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       TextButton(
              //           onPressed: () {
              //             // Navigator.pushNamed(context, 'Login');
              //           },
              //           child: const Text(
              //             "Click Here",
              //             style: TextStyle(
              //               color: Colors.grey,
              //               decoration: TextDecoration.underline,
              //               fontSize: 18,
              //               // fontWeight: FontWeight.bold,
              //             ),
              //           ))
              //     ],
              //   ),
              // ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SignupScreen())));
                },
                child: const Text(
                  "Don't have an Account ? SignUp Here",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
