import 'package:flutter/material.dart';

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
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeMember(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     final member = await Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AddMemberScreen()),
      //     );
      //     if (member != null) {
      //       addMember(member);
      //     }
      //   },
      // ),
    );
  }
}

// class AddMemberScreen extends StatelessWidget {
//   final TextEditingController _textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tambah Anggota Grup'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: InputDecoration(
//                 labelText: 'Nama Anggota',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               child: Text('Tambah'),
//               onPressed: () {
//                 final member = _textEditingController.text.trim();
//                 Navigator.pop(context, member);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
