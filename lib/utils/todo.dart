import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction});
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext) deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            backgroundColor: Colors.orange,
            onPressed: deleteFunction,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(20),
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, -1),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  side: const BorderSide(color: Colors.black, width: 3),
                  value: taskCompleted,
                  onChanged: onChanged),
              Text(
                taskName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white,
                    decorationThickness: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
