import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'homepage.dart';
class fullnote extends StatefulWidget {
  final oldTitle;
  final oldStarttype;
  final oldDate;
  final oldTime;
  const fullnote({required this.oldTitle,required this.oldStarttype,
    required this.oldDate,required this.oldTime,super.key});

  @override
  State<fullnote> createState() => _fullnoteState();
}

class _fullnoteState extends State<fullnote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => homepage()));
        },
        icon: Icon(Icons.arrow_back),
      ),

    ),
      body: Column(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width / 1.13,
              child: Text(widget.oldTitle.toString())),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.13,
              child: Text(widget.oldStarttype.toString())),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(widget.oldDate.toString()),
                Text(widget.oldTime.toString())
              ],
            )
          )
        ],
      ),);
  }
}
