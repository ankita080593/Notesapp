import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notedataapp/fullnote.dart';
import 'package:notedataapp/textnotepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> oldTitle = [];
  List<String> oldStarttype = [];
  List<String> oldDate = [];
  List<String>oldTime=[];
  void getdata() async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      oldTitle = pre.getStringList('ntceanktaTitle') ?? [];
      oldStarttype = pre.getStringList('ntceanktaStarttype') ?? [];
      oldDate = pre.getStringList('ntceanktaDate') ?? [];
      oldTime=pre.getStringList('ntceanktaTime')??[];
    });
    print(oldTime);
  }

  void removedata(int i) async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    oldTitle.removeAt(i);
    oldStarttype.removeAt(i);
    oldDate.removeAt(i);
    oldTime.removeAt(i);
    pre.setStringList("ntceanktaTitle", oldTitle);
    pre.setStringList("ntceanktaStarttype", oldStarttype);
    pre.setStringList("ntceanktaDate", oldDate);
    pre.setStringList("ntceanktaTime", oldTime);
    getdata();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('All notes')),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: oldTitle.length, // total number of items
        itemBuilder: (context, index) {
          return
            InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>fullnote(oldTitle: oldTitle[index],
                    oldStarttype: oldStarttype[index],
                    oldDate: oldDate[index],oldTime: oldTime[index],)));
            },
             child:Container(
                color: Colors.teal, // color of grid items
                child: Stack(
                  children: [Positioned(right: 10,top: 10,
                      child: CircleAvatar(radius:15,
                          child: IconButton(onPressed: (){
                            removedata(index);
                          },icon: Icon(Icons.close,size: 15,),))),
                    Positioned(child:
                    Column(
                    children: [
                      Text(
                        oldTitle[index],
                        style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        oldStarttype[index],
                        style: TextStyle(fontSize: 18.0, color: Colors.black54),
                      ),
                      Row(
                        children: [
                          Text(oldDate[index],
                            style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                          SizedBox(width: 10,),
                          Text(oldTime[index],
                            style: TextStyle(fontSize: 18.0, color: Colors.black54),)
                        ],
                      ),
                    ],
                  ),
                  )]),
              ),

          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => textnotepage()));
        },
        child: Icon(
          Icons.add,
        ),
        shape: CircleBorder(),
        backgroundColor: Colors.green,
      ),
    );
  }
}
