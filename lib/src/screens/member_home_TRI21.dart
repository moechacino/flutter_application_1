import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'form.dart';
import 'group_member.dart';
import 'tugas_member.dart';
import 'homePage.dart';
import 'edit_schedule_page.dart';
import 'show_schedules.dart';

class MemberHome extends StatefulWidget {
  @override
  _MemberHomeState createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  int _currentIndex = 0;

  // Fungsi untuk memperbarui jadwal
  Future<void> _refreshSchedule() async {
    // Tambahkan logika untuk memperbarui jadwal sesuai kebutuhan Anda
    // Misalnya, memanggil fungsi fetchScheduleData() kembali untuk mendapatkan jadwal terbaru

    setState(() {
      // Memperbarui tampilan jadwal setelah proses refresh selesai
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      // Ubah tab pertama menjadi tampilan jadwal kuliah
      HomePage(username: "kelompok 8"),
      SevenButtonsScreen(), // Menampilkan tabel jadwal kuliah
      TaskList(),
      GroupPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("PJMK"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshSchedule,
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(CupertinoIcons.person_alt_circle_fill)),
          BottomNavigationBarItem(
              label: 'Jadwal', icon: Icon(CupertinoIcons.calendar)),
          BottomNavigationBarItem(
              label: 'Tugas', icon: Icon(CupertinoIcons.list_dash)),
          BottomNavigationBarItem(
              label: 'Group', icon: Icon(CupertinoIcons.person_3)),
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
