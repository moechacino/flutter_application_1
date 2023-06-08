import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class HomePage extends StatelessWidget {
  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Tambahkan logika tambahan setelah logout, seperti menghapus token atau mengatur ulang data sesi

      // Navigasi kembali ke halaman login (contoh menggunakan GetX)
      Get.offAll(LoginScreen());
    } catch (e) {
      print('Terjadi kesalahan saat logout: $e');
      // Tambahkan penanganan kesalahan sesuai kebutuhan Anda
    }
  }

  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userUID = '';
    if (user != null) {
      userUID = user.uid;
    }
    Stream<DocumentSnapshot> getUserStream(String userUID) {
      return FirebaseFirestore.instance
          .collection('registrations')
          .doc(userUID)
          .snapshots();
    }

    // ignore: unused_local_variable

    return StreamBuilder<DocumentSnapshot>(
      stream: getUserStream(userUID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String namaLengkap = snapshot.data!.get('namaLengkap') ?? '';
          String statusMahasiswa = snapshot.data!.get('statusKelas') ?? '';
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Halo, $namaLengkap!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'current status: $statusMahasiswa',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    child: Text('Pengaturan'),
                    onPressed: () {
                      // Tambahkan logika untuk menavigasi ke halaman pengaturan
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.logout),
              onPressed: _logout,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Terjadi kesalahan');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
