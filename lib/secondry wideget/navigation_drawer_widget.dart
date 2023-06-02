import 'package:flutter/material.dart';
import 'package:my_captain/pages/safety.dart';

import '../Global/global.dart';
import '../MainScreen/about_screen.dart';
import '../MainScreen/profile_screen.dart';
import '../MainScreen/trips_history_screen.dart';
import '../SplashScreen/splash_screen.dart';
import '../pages/bookings.dart';
import '../pages/home.dart';
import '../pages/settings.dart';
import '../pages/user_page.dart';
import '../pages/wallet.dart';

class NavigationDrawerWidget extends StatefulWidget {
  String? name;
  String? email;

  NavigationDrawerWidget({this.name, this.email});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    const name = '';
    const email = '';
    const urlImage =
        'https://images.unsplash.com/photo-1567808291548-fc3ee04dbcf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80';

    return Drawer(
      child: Material(
        color: Color.fromRGBO(0, 0, 0, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: '',
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  // const SizedBox(height: 12),
                  // buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Bookings',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'History',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Visit Profile',
                    icon: Icons.person,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Wallet',
                    icon: Icons.wallet,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Safety',
                    icon: Icons.safety_check,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'About',
                    icon: Icons.info,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Sign Out',
                    icon: Icons.logout,
                    onClicked: () {
                      fAuth.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const MySplashScreen()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.email.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(0, 0, 0, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  // Widget buildSearchField() {
  //   const color = Colors.white;

  //   return TextField(
  //     style: const TextStyle(color: color),
  //     decoration: InputDecoration(
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       hintText: 'Search',
  //       hintStyle: TextStyle(color: color),
  //       prefixIcon: Icon(Icons.search, color: color),
  //       filled: true,
  //       fillColor: Colors.white12,
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Home(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Bookings(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Bookings(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TripsHistoryScreen(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Wallet(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutScreen(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Safety(),
        ));
        break;
      case 8:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Settings(),
        ));
        break;
    }
  }
}
