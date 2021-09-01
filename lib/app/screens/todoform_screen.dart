import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/app/models/todo_model.dart';
import 'package:todolist/app/providers/todo_provider.dart';

class TodoForm extends StatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  var _date = DateTime.now();
  final _formData = Map<String, Object>();
  final _formKey = GlobalKey<FormState>();

  final _descriptionFocus = FocusNode();

  @override
  void didChangeDependencies() {
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context).settings.arguments;

      if (arg != null) {
        final todo = arg as Todo;
        _formData['id'] = todo.id;
        _formData['title'] = todo.title;
        _formData['description'] = todo.description;
        _formData['date'] = todo.date;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();

    _descriptionFocus.dispose();
  }

  void _submitForm() {
    _formKey.currentState.save();

    Provider.of<TodoProvider>(context, listen: false).saveTodo(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _formData['title']?.toString(),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  onSaved: (value) => _formData['title'] = value,
                  decoration: InputDecoration(
                    hintText: "Title your task",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: _descriptionFocus,
                  initialValue: _formData['description']?.toString(),
                  onSaved: (value) => _formData['description'] = value,
                  decoration: InputDecoration(
                    hintText: "Describe your task",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${_date.day}/ ${_date.month}/ ${_date.year}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () async {
                            DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime(_date.year - 5),
                              lastDate: DateTime(_date.year + 5),
                            );
                            if (picked != null) {
                              setState(() {
                                _date = picked;
                                _formData['date'] = picked;
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.tag_faces_sharp,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Text("Save"),
                          onPressed: _submitForm,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
