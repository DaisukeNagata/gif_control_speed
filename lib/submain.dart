import 'package:flutter/material.dart';

class SubMainPage extends StatefulWidget {
  const SubMainPage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<SubMainPage> createState() => _SubMainState();
}

class _SubMainState extends State<SubMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
