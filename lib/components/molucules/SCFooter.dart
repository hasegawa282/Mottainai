import 'package:flutter/material.dart';

List<String> _pagePathes = [
  '/home',
  '/fridge',
];
///
/// Footer
///

class SCFooter extends StatefulWidget {
  const SCFooter({Key? key}) : super(key: key);

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State {
  int currentIndex = 0;
  void _onItemTapped(int index) {
    String pagePath = _pagePathes.length <= index ? '/home' : _pagePathes[index];
    setState((){
      currentIndex = index;
    });
    Navigator.pushNamed(context, pagePath);
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'Fridge'),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      );
  }
}
