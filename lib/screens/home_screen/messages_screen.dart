import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text('Messages screen', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
