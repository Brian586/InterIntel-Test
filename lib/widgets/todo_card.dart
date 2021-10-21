import 'package:flutter/material.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/models/todo_item.dart';

class TodoCard extends StatelessWidget {
  final TodoItem? item;

  const TodoCard({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCompleted = item!.completed!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            topLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: isCompleted
                  ? const Icon(Icons.check_box, color: InterIntel.themeColor,)
                  : const Icon(Icons.check_box_outline_blank_rounded, color: Colors.grey,),
              title: isCompleted
                  ? Text(item!.title!, style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey))
                  : Text(item!.title!),
              subtitle: isCompleted
                  ? const Text("Completed", style: TextStyle(color: InterIntel.themeColor),)
                  : const Text("Pending"),
            ),
          ],
        ),
      ),
    );
  }
}
