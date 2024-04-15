import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({Key? key}) : super(key: key);

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _tasksCollection;

  @override
  void initState() {
    super.initState();
    _tasksCollection = _firestore.collection('tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _tasksCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final taskDocs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: taskDocs.length,
                  itemBuilder: (context, index) {
                    final task = taskDocs[index];
                    return _buildTaskItem(
                      title: task['title'],
                      description: task['description'],
                      startDate: DateTime.parse(task['startDate']),
                      endDate: DateTime.parse(task['endDate']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text('My Task Manager'),
    );
  }

  Widget _buildTaskItem({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(width: 8),
              Text(
                'Start Date: ${startDate.toString()}',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(width: 16),
              Icon(Icons.calendar_today),
              SizedBox(width: 8),
              Text(
                'End Date: ${endDate.toString()}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _editTask(title),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteTask(title),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _addTask() async {
    // Implement adding task logic using a dialog or a new screen
    // For simplicity, this example adds a hardcoded task
    await _tasksCollection.add({
      'title': 'New Task',
      'description': 'Description of the new task',
      'startDate': DateTime.now().toString(),
      'endDate': DateTime.now().add(Duration(days: 1)).toString(),
    });
  }

  Future<void> _editTask(String title) async {
    // Implement editing task logic using a dialog or a new screen
    // For simplicity, this example updates the title of the task
    final task = await _tasksCollection.where('title', isEqualTo: title).get();
    final taskDocId = task.docs.first.id;
    await _tasksCollection.doc(taskDocId).update({'title': 'Edited Task'});
  }

  Future<void> _deleteTask(String title) async {
    // Implement deleting task logic
    final task = await _tasksCollection.where('title', isEqualTo: title).get();
    final taskDocId = task.docs.first.id;
    await _tasksCollection.doc(taskDocId).delete();
  }
}
