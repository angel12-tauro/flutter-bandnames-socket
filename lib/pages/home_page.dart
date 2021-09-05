import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bandnames_app/pages/models/band_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'metalica', votes: 5),
    Band(id: '2', name: 'gun´s and roses', votes: 10),
    Band(id: '3', name: 'queen', votes: 7),
    Band(id: '4', name: 'kiss', votes: 4),
    Band(id: '5', name: 'bon jovi', votes: 6),
    Band(id: '6', name: 'nirvana', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: bands.length,
        itemBuilder: (context, i) => ItemBandWidget(band: bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

    /// alert dialog segun la plataforma Android & IOS
  addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      //Android
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              )
            ],
          );
        },
      );
    }
    //IOS
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New band name:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

    //Agregar una nueva banda
  void addBandToList(String name) {
    if (name.length > 1) {
      //podemos agregar}
      this.bands.add(
            new Band(
              id: DateTime.now().toString(),
              name: name,
              votes: 0,
            ),
          );
      setState(() {});
    }

    Navigator.pop(context);
  }
}

class ItemBandWidget extends StatelessWidget {
  const ItemBandWidget({@required this.band});

  final Band band;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${band.id}');
        //TODO: LLAMADO DEL SERVER
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

      ///
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            band.name.substring(0, 2).toUpperCase(),
          ),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }
}
