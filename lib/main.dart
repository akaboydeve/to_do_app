import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index] = _tasks[index].startsWith('Done ')
          ? _tasks[index].substring(5)
          : 'Done ${_tasks[index]}';
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_tasks[index]),
            onTap: () => _toggleTask(index),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String task = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New Task'),
                content: TextField(
                  autofocus: true,
                  onSubmitted: (String value) {
                    Navigator.pop(context, value);
                  },
                ),
              );
            },
          );
          if (task != null) {
            _addTask(task);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
