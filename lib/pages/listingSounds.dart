import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tpf3/okidakor.dart';
import 'package:tpf3/jobconstructor.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Box<Job> jobBox;

  // Delete info from people box
  _deleteInfo(int index) {
    jobBox.deleteAt(index);
    print('Item deleted from box at index: $index');
  } //supprime la ligne dans la box dont l'id est visé

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    jobBox = Hive.box(MyApp.polememploi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People Info'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder( //permet de construire la liste en récupérant les données de la box. Les lignes seront mises les unes à la suite des autres, par ordre croissant d'id
        valueListenable: jobBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: Text('Empty'),
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
                  child: ListTile(
                    title: Text(personData.entreprise + "\n" +personData.radio + "\n" + personData.salairebrut + "\n" + personData.salairenet), //Ecrit le nom de l'entreprise, le statut ainsi que les salaires bruts et nets de la ligne
                    subtitle: Text(personData.description), //Ecrit le commentaire de la ligne
                    trailing: IconButton(
                      onPressed: () => _deleteInfo(index),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}