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
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeTask(taskDocs[index]);
                    },
                  ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final task = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (task != null) {
            addTask(task);
          }
        },
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Tugas',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Tambah'),
              onPressed: () {
                final task = _textEditingController.text.trim();
                Navigator.pop(context, task);
              },
            ),
          ],
        ),
      ),
    );
  }
}
