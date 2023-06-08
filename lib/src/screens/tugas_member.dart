import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  Stream<List<DocumentSnapshot>> readTasks() =>
      taskCollection.snapshots().map((snapshot) => snapshot.docs);

  void addTask(String task) async {
    await taskCollection.add({'task': task});
  }

  void removeTask(DocumentSnapshot document) async {
    await taskCollection.doc(document.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: readTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> taskDocs = snapshot.data!;
            List<String> tasks =
                taskDocs.map((doc) => doc['task'] as String).toList();
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Terjadi kesalahan: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
