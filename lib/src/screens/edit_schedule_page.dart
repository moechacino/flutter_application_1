import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSchedulePage extends StatefulWidget {
  final Map<String, dynamic> schedule;

  EditSchedulePage({required this.schedule});

  @override
  _EditSchedulePageState createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  final TextEditingController _mataKuliahController = TextEditingController();
  final TextEditingController _jamController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mataKuliahController.text = widget.schedule['mataKuliah'];
    _jamController.text = widget.schedule['jam'];
  }

  @override
  void dispose() {
    _mataKuliahController.dispose();
    _jamController.dispose();
    super.dispose();
  }

  Future<void> _updateSchedule() async {
    try {
      await FirebaseFirestore.instance
          .collection('schedules')
          .doc(widget
              .schedule.id) // Menggunakan ID dokumen untuk memperbarui data
          .update({
        'mataKuliah': _mataKuliahController.text,
        'jam': _jamController.text,
      });
      Navigator.pop(
          context); // Kembali ke halaman sebelumnya setelah pembaruan berhasil
    } catch (e) {
      print('Terjadi kesalahan saat memperbarui jadwal: $e');
      // Tambahkan penanganan kesalahan sesuai kebutuhan Anda
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Schedule'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _mataKuliahController,
              decoration: InputDecoration(labelText: 'Mata Kuliah'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _jamController,
              decoration: InputDecoration(labelText: 'Jam'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateSchedule,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
