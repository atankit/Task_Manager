import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'task.dart';

class AddTaskScreen extends StatefulWidget {
  final VoidCallback onTaskAdded;

  AddTaskScreen({required this.onTaskAdded});
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter title here',
                label:Text('Title'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                  enabledBorder:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(11),
                  )
              ),
            ),
            SizedBox(height: 11,),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: 'Enter description here',
                  label: Text('Description'),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  )
              )
            ),

        SizedBox(height: 11,),

            TextField(
              controller: dueDateController,
              decoration: InputDecoration(
                hintText: 'Enter due date (dd-MM-yyyy)',
                label: Text('Enter Due date'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                )
              )
            ),

            SizedBox(height: 11,),

            Row(
              children: [
                    Expanded(
                        child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          side:BorderSide(width: 1),
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ),
                      onPressed: () async{
                        String title = titleController.text;
                        String description = descriptionController.text;
                        String dueDate = dueDateController.text;
                         if(title.isNotEmpty && description.isNotEmpty && dueDate.isNotEmpty){
                           Task task = Task(title: title, description: description, dueDate: dueDate);
                           await dbHelper.insertTask(task);
                           widget.onTaskAdded(); // Call the callback to refresh tasks
                           Navigator.pop(context);
                         }
                         else{
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Text(
                                   'Please fill all the required blanks!!')));
                         }
                      },
                          child: Text('Save Task'),
                        ),),
                SizedBox(
                  width: 11,
                ),

                Expanded(
                    child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                    side:BorderSide(width: 1),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
