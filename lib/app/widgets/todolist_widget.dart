import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/models/todo_model.dart';
import 'package:todolist/app/providers/todo_provider.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(this.todo);

  final Todo todo;

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
      ),
      onDismissed: (_) {
        Provider.of<TodoProvider>(context, listen: false)
            .deleteTodo(widget.todo);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.todo.title.toString()),
                  Checkbox(
                      value: widget.todo.isDone,
                      onChanged: (value) {
                        setState(() {
                          widget.todo.isDone = !widget.todo.isDone;
                        });
                      }),
                ],
              ),
              children: [
                Text(
                  "Descrição",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    widget.todo.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Navigator.of(context).pushNamed(
                        "/entry",
                        arguments: widget.todo,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          Provider.of<TodoProvider>(context, listen: false)
                              .deleteTodo(widget.todo),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    /*
    ListTile(
      title: Text(todo.title),
      trailing: Row(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              "/entry",
              arguments: todo,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => Provider.of<TodoProvider>(context, listen: false)
                .deleteTodo(todo),
          )
        ],
      ),
    );*/
  }
}

/*

 IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () =>
                      Provider.of<TodoProvider>(context, listen: false)
                          .deleteTodo(todo),
                ),*/
