import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:notedataapp/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class textnotepage extends StatefulWidget {
  const textnotepage({super.key});

  @override
  State<textnotepage> createState() => _textnotepageState();
}

class _textnotepageState extends State<textnotepage> {
  TextEditingController titlecontoller = TextEditingController();
  TextEditingController typetext = TextEditingController();
  DateTime datetime = DateTime.now();
  String formattedDate = DateFormat.MMMMd().format(DateTime.now());
  String formattedTime = DateFormat.jm().format(DateTime.now());

  void savedata() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    String title = titlecontoller.text;
    String Starttype = typetext.text;
    if (title != '' && Starttype != '') {
      List<String> oldTitle = pre.getStringList('ntceanktaTitle') ?? [];
      List<String> oldStarttype = pre.getStringList('ntceanktaStarttype') ?? [];
      List<String> oldDate = pre.getStringList('ntceanktaDate') ?? [];
      List<String>oldTime=pre.getStringList('ntceanktaTime')??[];
      oldTitle.add(title);
      oldStarttype.add(Starttype);
      oldDate.add(formattedDate);
      oldTime.add(formattedTime);
      pre.setStringList("ntceanktaTitle", oldTitle);
      pre.setStringList("ntceanktaStarttype", oldStarttype);
      pre.setStringList("ntceanktaDate", oldDate);
      pre.setStringList("ntceanktaTime", oldTime);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homepage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            savedata();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => homepage()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                savedata();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: titlecontoller,
              decoration:
                  InputDecoration(hintText: 'Title', border: InputBorder.none),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.13,
              child: Text('$formattedDate  $formattedTime')),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: typetext,
              decoration: InputDecoration(
                  hintText: 'Start Typing', border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
