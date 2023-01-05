import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:todo_list/models/todo.dart';

import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adcione uma Tarefa',
                          hintText: 'Ex: Estudar',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        if (text != '') {
                          setState(
                            () {
                              Todo newTodo =
                                  Todo(title: text, dateTime: DateTime.now());
                              todos.add(newTodo);
                            },
                          );
                        } else {
                          print('string vazia');
                        }
                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('Você tem ${todos.length} tarefas pendentes'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todos.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14),
                      ),
                      child: Text(
                        'Limpar tudo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
