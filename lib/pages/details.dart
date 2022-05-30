import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../database/hive_tools.dart';
import '../theme/appcolors.dart';
import 'package:popdot/main.dart';

import '../widgets/liste_sons.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
    // soundBox = Hive.box(MyApp.boitesons);
    soundBox = Hive.box<Sound>('sounds');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
            child: Column(
          children: [
            Column(
              children: [
                Card(
                  borderOnForeground: false,
                  color: AppColors.darkGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                        width: 400,
                        height: 400,
                        child: Image.asset('assets/images/img_cover_test.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Titre du thème",
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Liste des sons : "),
            ),
            Column(
              children: [
                const SizedBox(height: 24),
                Container(
                  child: ValueListenableBuilder(
                    //permet de construire la liste en récupérant les données de la box. Les lignes seront mises les unes à la suite des autres, par ordre croissant d'id
                    valueListenable: soundBox.listenable(),
                    builder: (context, Box box, widget) {
                      if (box.isEmpty) {
                        return Center(
                          child: Text('Le thème ne contient aucun son'),
                        );
                      } else {
                        return SizedBox(
                          width: 600,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              var currentBox = box;
                              var soundData = currentBox.getAt(index)!;

                              return Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: AppColors.darkGrey),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding: EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 1.0,
                                                    color: Colors.white24))),
                                        //TODO mettre l'icone de la bd

                                        child: Icon(Icons.airplanemode_active,
                                            color: Colors.white),
                                      ),
                                      title: Text(
                                        soundData.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          IconButton(
                                            //TODO RENVOYER VERS FORMULAIRE MODIFICATION
                                            onPressed: () => _deleteInfo(index),
                                            icon: Icon(
                                              Icons.volume_up,
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
                                    ),
                                  ));
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
