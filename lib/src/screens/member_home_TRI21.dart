import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'form.dart';
import 'group_info.dart';
import 'tugas_list.dart';
import 'homePage.dart';
import 'edit_schedule_page.dart';

class MemberHome extends StatefulWidget {
  @override
  _MemberHomeState createState() => _MemberHomeState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<List<Map<String, dynamic>>> fetchScheduleData() async {
  try {
    QuerySnapshot querySnapshot =
        await _firestore.collection('schedules').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  } catch (e) {
    print('Terjadi kesalahan saat mengambil data jadwal: $e');
    return [];
  }
}

class _MemberHomeState extends State<MemberHome> {
  void _editSchedule(Map<String, dynamic> schedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSchedulePage(schedule: schedule),
      ),
    );
  }

  int _currentIndex = 1;
  final List<String> daysOrder = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];
  // Fungsi untuk memperbarui jadwal
  Future<void> _refreshSchedule() async {
    // Tambahkan logika untuk memperbarui jadwal sesuai kebutuhan Anda
    // Misalnya, memanggil fungsi fetchScheduleData() kembali untuk mendapatkan jadwal terbaru

    setState(() {
      // Memperbarui tampilan jadwal setelah proses refresh selesai
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildScheduleTable() {
      return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchScheduleData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan saat mengambil data'));
          } else {
            List<Map<String, dynamic>> scheduleData = snapshot.data!;

            // Sort the schedule by day and time
            scheduleData.sort((a, b) {
              int indexA = daysOrder.indexOf(a['hari']);
              int indexB = daysOrder.indexOf(b['hari']);
              if (indexA != indexB) {
                return indexA.compareTo(indexB);
              } else {
                // Extract the time components from the time string
                List<String> timeA = a['jam'].split(':');
                List<String> timeB = b['jam'].split(':');

                // Convert the time components to integers
                int hourA = int.parse(timeA[0]);
                int hourB = int.parse(timeB[0]);
                int minuteA = int.parse(timeA[1].split(' ')[0]);
                int minuteB = int.parse(timeB[1].split(' ')[0]);

                // Compare the time components
                if (hourA != hourB) {
                  return hourA.compareTo(hourB);
                } else {
                  return minuteA.compareTo(minuteB);
                }
              }
            });

            // Merge schedule data with the same day
            List<Map<String, dynamic>> mergedScheduleData = [];
            String currentDay = '';
            List<String> currentMataKuliah = [];
            List<String> currentJam = [];
            for (int i = 0; i < scheduleData.length; i++) {
              Map<String, dynamic> data = scheduleData[i];
              if (data['hari'] != currentDay) {
                if (currentDay.isNotEmpty) {
                  mergedScheduleData.add({
                    'hari': currentDay,
                    'jam': currentJam.join('\n'),
                    'mataKuliah': currentMataKuliah.join('\n'),
                  });
                }
                currentDay = data['hari'];
                currentJam = [data['jam']];
                currentMataKuliah = [data['mataKuliah']];
              } else {
                currentJam.add(data['jam']);
                currentMataKuliah.add(data['mataKuliah']);
              }
            }
            // Add the last group of data
            if (currentDay.isNotEmpty) {
              mergedScheduleData.add({
                'hari': currentDay,
                'jam': currentJam.join('\n'),
                'mataKuliah': currentMataKuliah.join('\n'),
              });
            }

            return SingleChildScrollView(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Hari',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Jam',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Mata Kuliah',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: mergedScheduleData.map((data) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(data['hari'])),
                      DataCell(Text(data['jam'])),
                      DataCell(Text(data['mataKuliah'])),
                    ],
                    onSelectChanged: (bool? selected) {
                      if (selected!) {
                        _editSchedule(
                            data); // Panggil fungsi _editSchedule saat DataRow dipilih
                      }
                    },
                  );
                }).toList(),
              ),
            );
          }
        },
      );
    }

    final tabs = [
      // Ubah tab pertama menjadi tampilan jadwal kuliah
      _buildScheduleTable(), // Menampilkan tabel jadwal kuliah
      TaskList(),
      GroupPage(),
      HomePage(username: "kelompok 8")
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("PJMK"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshSchedule,
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              label: 'Jadwal', icon: Icon(CupertinoIcons.calendar)),
          BottomNavigationBarItem(
              label: 'Tugas', icon: Icon(CupertinoIcons.list_dash)),
          BottomNavigationBarItem(
              label: 'Group', icon: Icon(CupertinoIcons.person_3)),
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(CupertinoIcons.person_alt_circle_fill))
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
