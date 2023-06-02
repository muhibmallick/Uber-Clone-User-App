import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
     String? name;

      final String urlImage;

    UserPage({
    Key? key,
     this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: const Text("Your Profile Photo"),
          centerTitle: true,
        ),
        body: Image.network(
          widget.urlImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
}
