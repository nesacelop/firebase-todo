import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(FirebaseApp());

class FirebaseApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold( 
        appBar: AppBar(title: Text('Tareas Firebase')),
        body: StreamBuilder(
          stream: Firestore.instance.collection('tareas').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            List<DocumentSnapshot> docs = snapshot.data.documents;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = docs[index].data;
                return ListTile(
                  leading: Checkbox(value: data['done']),
                  title: Text(data['what']),
                );
              },
            );
          },
        )
      ),
    );
  }
}

