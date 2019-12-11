import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class create extends StatefulWidget {
  @override
  _createState createState() => _createState();
}

class _createState extends State<create> {
  final title = new TextEditingController() ;
  final body = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          submit();
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.check),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          color: Colors.black,
        ),
      ),
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        title: new Text("Notes App"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0)
                  ),
                  color: Color(0xa1ffffff)
                ),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title"
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(9.0)
                    ),
                    color: Color(0xa1ffffff)
                ),
                height: 200.0,
                child: TextField(
                  maxLines: 8,
                  controller: body,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Body"
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  submit() async{
    await Firestore.instance.collection('notes').document()
        .setData({ 'title': title.text, 'body': body.text });
    Navigator.pop(context);
  }
}
