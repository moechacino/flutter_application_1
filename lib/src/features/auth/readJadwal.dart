import 'package:firebase_database/firebase_database.dart';

void readData() {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('jadwal_mata_kuliah');

  databaseReference.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, values) {
      // Lakukan pemrosesan data di sini
      print('Nama Mata Kuliah: ${values['nama']}');
      print('Dosen: ${values['dosen']}');
      print('Jam Mulai: ${values['jam_mulai']}');
      print('Jam Selesai: ${values['jam_selesai']}');
      print('-----------------------');
    });
  });
}
