import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
      );
}
