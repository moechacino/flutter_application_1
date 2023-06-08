import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleForm extends StatefulWidget {
  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addSchedule(Map<String, dynamic> scheduleData) async {
    try {
      String hari = scheduleData['hari']; // Mendapatkan nilai 'hari'
      DocumentReference docRef = _firestore.collection(hari).doc();

      // Menambahkan dokumen baru dengan field 'jam' dan 'mataKuliah' sebagai string
      await docRef.set({
        'jam': scheduleData['jam'],
        'mataKuliah': scheduleData['mataKuliah']
      });

      print('Jadwal berhasil ditambahkan');
    } catch (e) {
      print('Terjadi kesalahan saat menambahkan jadwal: $e');
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mataKuliahController = TextEditingController();
  String _selectedHari = 'Senin';
  TimeOfDay? _selectedTime;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Membuat map data jadwal kuliah
      Map<String, dynamic> newSchedule = {
        'hari': _selectedHari,
        'jam': _selectedTime != null ? _selectedTime!.format(context) : '',
        'mataKuliah': _mataKuliahController.text,
      };

      // Panggil fungsi addSchedule atau updateSchedule sesuai kebutuhan
      // Jika Anda ingin menambahkan jadwal baru, gunakan addSchedule
      // Jika Anda ingin memperbarui jadwal yang sudah ada, gunakan updateSchedule dengan memasukkan docId yang sesuai
      // Contoh:
      addSchedule(newSchedule);
      // updateSchedule(docId, newSchedule);

      // Mengosongkan nilai input setelah submit
      _mataKuliahController.clear();
      setState(() {
        _selectedHari = 'Senin';
        _selectedTime = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _selectedHari,
            onChanged: (newValue) {
              setState(() {
                _selectedHari = newValue!;
              });
            },
            items: <String>[
              'Senin',
              'Selasa',
              'Rabu',
              'Kamis',
              'Jumat',
              'Sabtu',
              'Minggu',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(labelText: 'Hari'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setState(() {
                _selectedTime = selectedTime;
              });
            },
            child: Text(_selectedTime != null
                ? _selectedTime!.format(context)
                : 'Pilih Jam'),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _mataKuliahController,
            decoration: InputDecoration(labelText: 'Mata Kuliah'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Harap masukkan mata kuliah';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
