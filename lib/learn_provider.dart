import 'package:flutter/material.dart';

void main() {
  runApp(const LearnProvider());
}

class Todo {
  String title;
  String desc;

  Todo({
    required this.title,
    required this.desc,
  });

  @override
  int get hashCode => Object.hash(title, desc);

  @override
  bool operator ==(Object other) {
    return other is Todo && other.title == title && other.desc == desc;
  }
}

class TodoController with ChangeNotifier {
  List<Todo> _items = [];

  createTodo(String title, String desc) {
    if (title.isEmpty || desc.isEmpty) return;

    final todo = Todo(title: title, desc: desc);
    _items.add(todo);
    notifyListeners();
  }

  List<Todo> get todos => _items;

  void deleteTodo(Todo todo) {
    _items.remove(todo);
    notifyListeners();
  }
}

class Provider extends InheritedWidget {
  final TodoController controller;

  const Provider({required this.controller, super.key, required super.child});

  static TodoController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.controller;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return oldWidget.controller.todos != controller.todos;
  }
}

class LearnProvider extends StatelessWidget {
  const LearnProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      controller: TodoController(),
      child: const MaterialApp(
        home: HomeProvider(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Todos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => DetailProvider(),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: Provider.of(context),
        builder: (context, _) {
          final todos = Provider.of(context).todos;
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.desc),
                  trailing: IconButton(
                    onPressed: () => Provider.of(context).deleteTodo(todo),
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailProvider extends StatelessWidget {
  DetailProvider({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Todo"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (builder) => const HomeProvider(),
              ),
            ),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: "Description"),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
