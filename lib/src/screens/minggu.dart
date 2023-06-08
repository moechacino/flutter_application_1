import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MingguScreen extends StatelessWidget {
  final CollectionReference collectionMinggu =
      FirebaseFirestore.instance.collection('Minggu');

  Stream<List<Map<String, dynamic>>> readMinggu() =>
      collectionMinggu.snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList(),
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Minggu'),
      ),
      body: Center(
        child: tableMinggu(),
      ),
    );
  }

  Widget tableMinggu() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: readMinggu(),
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
                DataCell(Text(collectionMinggu.id)),
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
