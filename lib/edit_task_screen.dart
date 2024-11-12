
import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'task.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dueDateController;
  bool isCompleted = false;

  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    dueDateController = TextEditingController(text: widget.task.dueDate);
    isCompleted = widget.task.completed == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: dueDateController,
              decoration: InputDecoration(labelText: 'Due Date'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed Status'),
                Switch(
                  value: isCompleted,
                  onChanged: (value) {
                    setState(() {
                      isCompleted = value;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String description = descriptionController.text;
                String dueDate = dueDateController.text;
                Task updatedTask = Task(
                  id: widget.task.id,
                  title: title,
                  description: description,
                  dueDate: dueDate,
                  completed: isCompleted ? true : false,
                );
                await dbHelper.updateTask(updatedTask);
                Navigator.pop(context);
              },
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}