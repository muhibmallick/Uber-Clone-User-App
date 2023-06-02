import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
      );
}
