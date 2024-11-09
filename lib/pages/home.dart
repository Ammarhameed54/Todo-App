/*

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo/utils/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TextEditingController controller;
  late AnimationController animationController;
  late Animation animation;
  late Animation widthAnimation;
  late Animation heightAnimation;
  List todoList = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.0, 0.4)),
    );
    widthAnimation = Tween(begin: 0.0, end: 200).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.4, 0.7)),
    );
    heightAnimation = Tween(begin: 0.0, end: 200).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.7, 1.0)),
    );

    animationController.addListener(() {
      setState(() {}); // Rebuilds to reflect animation changes
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    controller.dispose();
  }

  void checkBoxChanged(int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void saveTask() {
    setState(() {
      todoList.add([controller.text, false]);
      controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
      ),
      backgroundColor: Colors.blue.shade100,
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, index) {
          return TodoList(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Transform.rotate(
        angle: animation.value,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            animationController.forward(
                from: 0); // Start or restart the animation
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.add),
                    ),
                  ],
                  content: Container(
                    width: widthAnimation.value,
                    height: heightAnimation.value,
                    child: TextField(),
                  ),
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
*/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo/utils/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TextEditingController controller;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> widthAnimation;
  late Animation<double> heightAnimation;
  List todoList = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
          parent: animationController, curve: const Interval(0.0, 0.4)),
    );
    widthAnimation = Tween(begin: 0.0, end: 500.0).animate(
      CurvedAnimation(
          parent: animationController, curve: const Interval(0.4, 0.7)),
    );
    heightAnimation = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(
          parent: animationController, curve: const Interval(0.7, 1.0)),
    );

    animationController.addListener(() {
      setState(() {}); // Rebuilds to reflect animation changes
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  void checkBoxChanged(int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void saveTask() {
    setState(() {
      todoList.add([controller.text, false]);
      controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void _showAnimatedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withOpacity(1),
                        offset: Offset(0, 3),
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Color(0xFF000000).withOpacity(0),
                        offset: Offset(0, -2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade200, Colors.orange.shade100],
                      stops: const [0, 1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                width: widthAnimation.value,
                height: heightAnimation.value,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: 'Enter task',
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          saveTask();
                          Navigator.pop(context);
                        },
                        icon: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.orange,
                            child: Icon(Icons.add)))
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    // Start the width and height animations after opening the dialog
    animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange.shade200,
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, index) {
          return TodoList(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Transform.rotate(
        angle: animation.value,
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: _showAnimatedDialog,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
