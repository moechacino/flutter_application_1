import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KamisScreen extends StatelessWidget {
  final CollectionReference collectionKamis =
      FirebaseFirestore.instance.collection('Kamis');

  Stream<QuerySnapshot<Map<String, dynamic>>> readKamis() => collectionKamis
      .snapshots()
      .map((snapshot) => snapshot as QuerySnapshot<Map<String, dynamic>>);

  Future<void> deleteData(String docId) async {
    try {
      await collectionKamis.doc(docId).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('Failed to delete data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Kamis'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: tableKamis(),
        ),
      ),
    );
  }

  Widget tableKamis() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: readKamis(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList =
              snapshot.data!.docs;
          return DataTable(
            columns: [
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
              DataColumn(
                label: Text(
                  'Action',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
            rows: dataList.map((doc) {
              String docId = doc.id;
              String jam = doc['jam'] ?? '';
              String mataKuliah = doc['mataKuliah'] ?? '';
              return DataRow(cells: [
                DataCell(Text(jam)),
                DataCell(Text(mataKuliah)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteData(docId);
                    },
                  ),
                ),
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