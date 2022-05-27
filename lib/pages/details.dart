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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                Card(
                  child: ValueListenableBuilder(
                    //permet de construire la liste en récupérant les données de la box. Les lignes seront mises les unes à la suite des autres, par ordre croissant d'id
                    valueListenable: soundBox.listenable(),
                    builder: (context, Box box, widget) {
                      if (box.isEmpty) {
                        return Center(
                          child: Text('Le thème ne contient aucun son'),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
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
                                child: ListTile(
                                  leading: Icon(
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
                                ));
                          },
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
