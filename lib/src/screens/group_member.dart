import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  String groupName = 'TRI 21';
  List<String> members = [];

  void updateGroupName(String name) {
    setState(() {
      groupName = name;
    });
  }

  void addMember(String member) {
    setState(() {
      members.add(member);
    });
  }

  void removeMember(int index) {
    setState(() {
      members.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMembers();
  }

  Future<void> fetchMembers() async {
    CollectionReference registrationCollection =
        FirebaseFirestore.instance.collection('registrations');
    QuerySnapshot snapshot = await registrationCollection.get();
    List<String> memberNames = [];
    snapshot.docs.forEach((doc) {
      String namaLengkap = doc['namaLengkap'] ?? '';
      memberNames.add(namaLengkap);
    });
    setState(() {
      members = memberNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              groupName,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Anggota Grup:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(members[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
