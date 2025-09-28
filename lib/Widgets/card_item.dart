import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {
  CardItem({
    super.key,
    required this.subTitle,
    required this.title,
    required this.onPressed,
  });

  String title;
  String subTitle;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        trailing: IconButton(
          color: Colors.red,
          onPressed: onPressed,
          icon: Icon(Icons.delete),
        ),
        title: Text(title, style: TextStyle(color: Colors.black, fontSize: 20)),
        subtitle: Text(
          subTitle,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
