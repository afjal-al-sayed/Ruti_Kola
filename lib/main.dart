import 'package:flutter/material.dart';
import 'package:ruti_kola/screens/HomeScreeen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ruti Kola",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ruti Kola"),
          /*actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert),
            )
          ],*/
          //leading: Icon(Icons.cake),
        ),
        body: HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}



