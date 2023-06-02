import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_captain/SplashScreen/splash_screen.dart';

import '../Global/global.dart';
import '../widgets/progress_dialog.dart';
import 'Login.dart';


class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController NameTextEditingController = TextEditingController();
  TextEditingController EmailTextEditingController = TextEditingController();
  TextEditingController PhoneTextEditingController = TextEditingController();
  TextEditingController PasswordTextEditingController = TextEditingController();

  validationform() {
    if (NameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "Name must be atleast 3 characters Long.");
    } else if (!EmailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email is not valid.");
    } else if (PhoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone number is required");
    } else if (PasswordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be atleast 6 characters long");
    } else {
      SaveUserInfoNow();
    }
  }

  SaveUserInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: EmailTextEditingController.text.trim(),
      password: PasswordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error:  " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      Map UserMap = {
        
        "id": firebaseUser.uid,
        "name": NameTextEditingController.text.trim(),
        "email": EmailTextEditingController.text.trim(),
        "phone": PhoneTextEditingController.text.trim(),
      };
      DatabaseReference UserRefrence =
          FirebaseDatabase.instance.ref().child("Users");
      UserRefrence.child(firebaseUser.uid).set(UserMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has successfully created.");
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => MySplashScreen())));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/logo.png"),
              ),
              const Text(
                "Register as User",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //**************Text Field 1 *************
              TextField(
                controller: NameTextEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
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
              ),
              //********Textfield END**********
              TextField(
                controller: PhoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
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
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightGreenAccent),
                child: const Text(
                  "Create an Account",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              //********Sizebox**********
              const SizedBox(
                height: 20,
              ),
              //*****************Textbutton****************
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginScreen())));
                },
                child: const Text(
                  "Already have an Account ? Click Here",
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
