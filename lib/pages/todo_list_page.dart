import 'package:flutter/material.dart';
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
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adcione uma Tarefa',
                          hintText: 'Ex: Estudar',
                        ),
                      ),
                    ),
                    const SizedBox(
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
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('Você tem ${todos.length} tarefas pendentes'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: clearAll,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Text(
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

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} excluida com sucesso!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.black,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void clearAll() {
    if (todos.length != 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Limpar Tudo ?'),
          content: Text('Voce tem certeza que deseja apagar todas as tarefas?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todos.clear();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nenhuma tarefa encontrada!',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  

}
