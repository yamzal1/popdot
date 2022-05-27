import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:popdot/main.dart';
import 'package:popdot/database/hive_tools.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Box<Sound> soundBox;

  // Delete info from people box
  _deleteInfo(int index) {
    soundBox.deleteAt(index);
    print('Item deleted from box at index: $index');
  } //supprime la ligne dans la box dont l'id est visé

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    soundBox = Hive.box(MyApp.boitesons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      floatingActionButton: FloatingActionButton(
        //TODO ajout son ici
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        ),
        child: Icon(Icons.add),
      ),

      body: ValueListenableBuilder( //permet de construire la liste en récupérant les données de la box. Les lignes seront mises les unes à la suite des autres, par ordre croissant d'id
        valueListenable: soundBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: Text('Le thème ne contient aucun son'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                var personData = currentBox.getAt(index)!;
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ),
                  ),
                    child : ListTile(
                      leading:Icon(
                        //TODO mettre l'icone de la bd (besoin du formulaire d'ajout)
                        Icons.directions_car_filled,
                        color: Colors.black,
                      ),
                      title: Text(personData.name),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[

                      IconButton(
                        //TODO RENVOYER VERS LE FORMULAIRE DE LOUIS.T
                          onPressed: () => _deleteInfo(index),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),

                      IconButton(
                          onPressed: () => _deleteInfo(index),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),

                          // icon-1
                        ],
                      ),
                    )


                );
              },
            );
          }
        },
      ),
    );
  }
}