import 'package:flutter/material.dart';
import 'package:ruti_kola/model/ItemCount.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ItemCount itemCount;

  void addItemCount(String itemName){
    //print(itemName);
    if(itemName == "Ruti"){
      setState(() {
        itemCount.rutiCount = itemCount.rutiCount + 1;
      });
    }else if(itemName == "Kola"){
      setState(() {
        itemCount.kolaCount = itemCount.kolaCount + 1;
      });
    }else if(itemName == "Cake"){
      setState(() {
        itemCount.cakeCount = itemCount.cakeCount + 1;
      });
    }else{
      setState(() {
        itemCount.classCount = itemCount.classCount + 1;
      });
    }
    saveItemCount();
  }

  void removeItemCount(String itemName){
    if(itemName == "Ruti"){
      if(itemCount.rutiCount > 0){
        setState(() {
          itemCount.rutiCount = itemCount.rutiCount - 1;
        });
      }
    }else if(itemName == "Kola"){
      if(itemCount.kolaCount > 0){
        setState(() {
          itemCount.kolaCount = itemCount.kolaCount - 1;
        });
      }
    }else if(itemName == "Cake"){
      if(itemCount.cakeCount > 0){
        setState(() {
          itemCount.cakeCount = itemCount.cakeCount - 1;
        });
      }
    }else{
      if(itemCount.classCount > 0){
        setState(() {
          itemCount.classCount = itemCount.classCount - 1;
        });
      }
    }
    saveItemCount();
  }

  void saveItemCount() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("class", itemCount.classCount);
    await prefs.setInt("ruti", itemCount.rutiCount);
    await prefs.setInt("kola", itemCount.kolaCount);
    await prefs.setInt("cake", itemCount.cakeCount);
  }

  void getSavedCount() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int classCount = await prefs.getInt("class") ?? 0;
    int rutiCount = await prefs.getInt("ruti") ?? 0;
    int kolaCount = await prefs.getInt("kola") ?? 0;
    int cakeCount = await prefs.getInt("cake") ?? 0;
    setState(() {
      itemCount = ItemCount(
          rutiCount: rutiCount,
          kolaCount: kolaCount,
          cakeCount: cakeCount,
          classCount: classCount
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              summerySection(itemCount),
              updateSection(itemCount, addItemCount, removeItemCount)
            ],
          ),
        ),
      ),
    );
  }

  _HomeScreenState(){
    itemCount = ItemCount(
        rutiCount: 0,
        kolaCount: 0,
        cakeCount: 0,
        classCount: 0
    );
    getSavedCount();
  }
}

Widget summerySection(ItemCount itemCount){
  return Card(
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingText("Summery"),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Divider(
                height: 4.0,
                color: Colors.black38,
              ),
            ),
            classItem(itemCount.classCount, "assets/images/classroom.png"),
            summeryItem("Ruti", itemCount.rutiCount, "assets/images/naan.png"),
            summeryItem("Kola", itemCount.kolaCount, "assets/images/banana.png"),
            summeryItem("Cake", itemCount.cakeCount, "assets/images/cake.png"),
          ],
        ),
      ),
    ),
  );
}

Widget headingText(String title){
  return Text(
    title,
    style: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget summeryItem(String itemName, int itemCount, String image){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image(
            image: AssetImage(image),
            height: 48.0,
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: "${itemName}", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " is given "),
              TextSpan(text: "${itemCount}", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " times")
            ]
          )
        ),
      ],
    ),
  );
}

Widget classItem(int classCount, String image){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image(
            image: AssetImage(image),
            height: 48.0,
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              //TextSpan(text: "${itemName}", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "Attended total "),
              TextSpan(text: "${classCount}", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " classes")
            ]
          )
        ),
      ],
    ),
  );
}

Widget updateSection(ItemCount initialCount, Function addItemCount, Function removeItemCount){
  return Card(
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingText("Update info"),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0, top: 2.0),
              child: Divider(
                height: 4.0,
                color: Colors.black38,
              ),
            ),
            updateItem("Classes Attended", "assets/images/classroom.png", initialCount.classCount, addItemCount, removeItemCount),
            updateItem("Ruti", "assets/images/naan.png", initialCount.rutiCount, addItemCount, removeItemCount),
            updateItem("Kola", "assets/images/banana.png", initialCount.kolaCount, addItemCount, removeItemCount),
            updateItem("Cake", "assets/images/cake.png", initialCount.cakeCount, addItemCount, removeItemCount),
          ],
        ),
      ),
    ),
  );
}

Widget updateItem(String name, String image, int itemCount, Function addItemCount, Function removeItemCount){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image(
            image: AssetImage(image),
            height: 48.0,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey)
          ),
          alignment: Alignment.center,
          child: Text(
              "${itemCount}",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
          ),
        ),
        SizedBox(
          width: 4.0,
        ),
        FloatingActionButton.small(
          backgroundColor: Colors.red[700],
          elevation: 4.0,
          onPressed: (){
            removeItemCount(name);
          },
          child: Icon(Icons.remove),
        ),
        FloatingActionButton.small(
          elevation: 4.0,
          onPressed: (){
            addItemCount(name);
          },
          child: Icon(Icons.add),
        )
      ],
    ),
  );
}
