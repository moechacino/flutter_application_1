import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberHome extends StatefulWidget {
  @override
  _MemberHomeState createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  int _currentIndex = 1;
  final tabs = [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('data'),
    ),
    Center(
      child: Text('data2'),
    ),
    Center(
      child: Text('data3'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("PJMK"),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              label: 'Jadwal', icon: Icon(CupertinoIcons.calendar)),
          BottomNavigationBarItem(
              label: 'Tugas', icon: Icon(CupertinoIcons.list_dash)),
          BottomNavigationBarItem(
              label: 'Group', icon: Icon(CupertinoIcons.person_3)),
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(CupertinoIcons.person_alt_circle_fill))
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
