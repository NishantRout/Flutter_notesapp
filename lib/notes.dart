import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notesapp/create.dart';

class notes extends StatefulWidget {
  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff202020),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          transport(create());
        },
        child: Icon(Icons.add),
        elevation: 4.0,
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: 50.0,
        ),
      ),
      appBar: AppBar(
        title: new Text("Notes App"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('notes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(
              child: new CircularProgressIndicator(),
            );
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,4.0,8.0,1.0),
                    child: Card(
                      elevation: 0.0,
                      color: Colors.grey,
                      child: new ListTile(
                        title: new Text(document['title'], style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                        subtitle: new Text(document['body'], style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              Firestore.instance.collection('notes').document(document.documentID)
                                  .delete();
                            }),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
  transport(Widget n){
    Navigator.push(context, MaterialPageRoute(builder: (context) => n));
  }
}
