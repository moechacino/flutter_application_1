import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedOption, selectedOption2;
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
                    decoration: InputDecoration(
                        label: Text("Nama Lengkap"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Alamat Email"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Username"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Password"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text("Ulangi Password"),
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedOption2,
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
                      selectedOption2 = value;
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
                    value: selectedOption,
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
                      selectedOption = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Status di Kelas',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("DAFTAR")))
                ],
              )),
            )
          ]),
        )),
      ),
    );
  }
}
