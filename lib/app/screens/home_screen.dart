import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/app/providers/todo_provider.dart';
import 'package:todolist/app/screens/todoform_screen.dart';
import 'package:todolist/app/widgets/todolist_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    initSharedPreferences();

    super.initState();
  }

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Provider.of<TodoProvider>(context, listen: false).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    print(todoProvider.todosCount);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.25,
        title: Column(
          children: [
            Text(
              "Tasker",
              style: TextStyle(
                fontSize: size.width * 0.1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "21",
                      style: TextStyle(fontSize: size.width * 0.12),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AUG",
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                          ),
                        ),
                        Text(
                          "2021",
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  "WEDNESDAY",
                  style: TextStyle(fontSize: size.width * 0.03),
                )
              ],
            )
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: todoProvider.todosCount,
        itemBuilder: (BuildContext context, int index) {
          return TodoItem(todoProvider.todos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTaskBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return Container(height: 350, child: TodoForm());
        });
  }
}
