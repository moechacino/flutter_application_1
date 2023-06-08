import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/welcome_screens.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ulangiPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? selectedKelas, selectedStatusKelas;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Aplikasi PJMK"),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: namaLengkapController,
                    decoration: InputDecoration(
                        label: Text("Nama Lengkap"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        label: Text("Alamat Email"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        label: Text("Username"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    controller: ulangiPasswordController,
                    decoration: InputDecoration(
                        label: Text("Ulangi Password"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedKelas,
                    items: [
                      DropdownMenuItem(
                        value: '1 D4 TRI',
                        child: Text('1 D4 TRI'),
                      ),
                      DropdownMenuItem(
                        value: '2 D4 TRI',
                        child: Text('2 D4 TRI'),
                      ),
                    ],
                    onChanged: (value) {
                      selectedKelas = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Kelas',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedStatusKelas,
                    items: [
                      DropdownMenuItem(
                        value: 'PJ Mata Kuliah',
                        child: Text('PJ Mata Kuliah'),
                      ),
                      DropdownMenuItem(
                        value: 'Mahasiswa Biasa',
                        child: Text('Mahasiswa Biasa'),
                      ),
                    ],
                    onChanged: (value) {
                      selectedStatusKelas = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Status di Kelas',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Mendapatkan nilai-nilai dari TextFormField dan DropdownButtonFormField
                            String namaLengkap = namaLengkapController.text;
                            String email = emailController.text;
                            String username = usernameController.text;
                            String password = passwordController.text;
                            String ulangiPassword =
                                ulangiPasswordController.text;
                            String kelas = selectedKelas!;
                            String statusKelas = selectedStatusKelas!;

                            try {
                              // Melakukan pengiriman data ke Firebase Authentication
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                              // Mendapatkan UID pengguna yang baru didaftarkan
                              String userUID = userCredential.user!.uid;

                              // Memasukkan UID pengguna ke dalam dokumen registrasi di Firestore
                              // await registrationRef
                              //     .update({'userUID': userUID});

                              // Menyimpan data registrasi dalam Firestore
                              DocumentReference registrationRef =
                                  FirebaseFirestore.instance
                                      .collection('registrations')
                                      .doc(userUID);

                              await registrationRef.set({
                                'namaLengkap': namaLengkap,
                                'email': email,
                                'username': username,
                                'kelas': kelas,
                                'statusKelas': statusKelas,
                              });

                              // Data berhasil dikirim
                              // Lakukan tindakan atau navigasi selanjutnya
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()),
                              );
                            } catch (error) {
                              // Terjadi kesalahan saat menyimpan data atau mengirim data ke Firebase Authentication
                              // Tampilkan pesan kesalahan atau lakukan tindakan sesuai kebutuhan
                              print('Terjadi kesalahan saat mendaftar: $error');
                            }
                          },
                          child: Text("DAFTAR")))
                ],
              )),
            )
          ]),
        )),
      ),
    );
  }
}
