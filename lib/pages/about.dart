import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../database/hive_tools.dart';
import '../theme/app_colors.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {





    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Image.asset('assets/images/logo_rogne.png'),
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        ),

        backgroundColor: AppColors.white,
        body: Center(


          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[



                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text(
                                        "Popdot | version 0.6.30",
                                      ),
                                      Divider(),
                                      ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text("Le jukebox qui dépote"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: const <Widget>[
                                            Text("27"),
                                            Text("Thèmes"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: const <Widget>[
                                            Text("213"),
                                            Text("Sons"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(
                          height: 20,
                        ),


                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: const <Widget>[
                              ListTile(
                                title: Text("Informations"),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("Email"),
                                subtitle: Text(
                                    "jules.combelles@universite-paris-saclay.fr\nalexandre.just@universite-paris-saclay.fr\nlouis.tripe@universite-paris-saclay.fr\nlouis.collin@universite-paris-saclay.fr\nyannis.amzal@universite-paris-saclay.fr"),
                                leading: Icon(
                                  Icons.email,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Github"),
                                subtitle:
                                    Text("https://github.com/yamzal1/popdot"),
                                leading: Icon(
                                  Icons.account_tree,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("À propos de nous"),
                                subtitle: Text(
                                    "Cette application a été réalisé par 5 étudiants dans le cadre \nd'un projet universitaire. \nNous espérons qu'elle vous plaira !"),
                                leading: Icon(
                                  Icons.group,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Date de création"),
                                subtitle: Text("23 Mai 2022"),
                                leading: Icon(
                                  Icons.date_range,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),





                        const SizedBox(
                          height: 20,
                        ),


                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: const <Widget>[
                              ListTile(
                                title: Text("Répartition des tâches"),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("Jules"),
                                subtitle: Text(
                                    "tout"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Alexandre"),
                                subtitle:
                                    Text("Conception des écrans \nImplémentation des formulaires et des thèmes \ntravail backend"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Louis T."),
                                subtitle: Text(
                                    "?"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Louis C."),
                                subtitle: Text("Conception des écrans \nFont-End formulaires"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Yannis"),
                                subtitle: Text(""),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),





                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
