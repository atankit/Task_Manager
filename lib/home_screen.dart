import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'db_helper.dart';
import 'task.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBHelper dbHelper = DBHelper();
  late Future<List<Task>> _taskFuture;

  @override
  void initState() {
    super.initState();
    _taskFuture = dbHelper.getTasks(); // Initialize the future
  }

  void _refreshTasks() {
    setState(() {
      _taskFuture = dbHelper.getTasks(); // Recreate the future to reload tasks
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Task> tasks = snapshot.data!;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: task.completed ? Colors.green : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    task.description,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.dueDate,
                        style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Check icon if task is completed
                        if (task.completed)
                          FaIcon(FontAwesomeIcons.check, size: 20, color: Colors.green, ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () async {
                            // Edit task screen
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTaskScreen(task: task),
                              ),
                            );
                            _refreshTasks(); // Refresh after editing
                          },
                          child: FaIcon(
                            FontAwesomeIcons.penToSquare,
                            size: 20,
                            color: Colors.cyan,
                          ),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () async {
                            await dbHelper.deleteTask(task.id!);
                            _refreshTasks(); // Refresh after deleting
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Task Deleted')),
                            );
                          },
                          child: FaIcon(
                            FontAwesomeIcons.trash,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(onTaskAdded: _refreshTasks),
            ),
          );
          _refreshTasks();
        },
        child: FaIcon(FontAwesomeIcons.plus)
      ),
    );
  }
}
