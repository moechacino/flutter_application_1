import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KamisScreen extends StatelessWidget {
  final CollectionReference collectionKamis =
      FirebaseFirestore.instance.collection('Kamis');

  Stream<List<Map<String, dynamic>>> readKamis() =>
      collectionKamis.snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList(),
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Kamis'),
      ),
      body: Center(
        child: tableKamis(),
      ),
    );
  }

  Widget tableKamis() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: readKamis(),
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
                DataCell(Text(collectionKamis.id)),
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
