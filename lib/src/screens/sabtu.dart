import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SabtuScreen extends StatelessWidget {
  final CollectionReference collectionSabtu =
      FirebaseFirestore.instance.collection('Sabtu');

  Stream<List<Map<String, dynamic>>> readSabtu() =>
      collectionSabtu.snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList(),
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Sabtu'),
      ),
      body: Center(
        child: tableSabtu(),
      ),
    );
  }

  Widget tableSabtu() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: readSabtu(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> dataList = snapshot.data!;
          return DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Hari',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              DataColumn(
                label: Text(
                  'Jam',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              DataColumn(
                label: Text(
                  'Mata Kuliah',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
            rows: dataList.map((data) {
              String jam = data['jam'] ?? '';
              String mataKuliah = data['mataKuliah'] ?? '';
              return DataRow(cells: [
                DataCell(Text(collectionSabtu.id)),
                DataCell(Text(jam)),
                DataCell(Text(mataKuliah)),
              ]);
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text('Terjadi kesalahan: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
