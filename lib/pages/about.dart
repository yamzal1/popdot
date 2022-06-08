import 'package:flutter/material.dart';

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
              child: Image.asset('assets/images/popdot_web_qr_code.png'),
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
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: const [
                              ListTile(
                                title: Text("Information"),
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
                                title: Text("About us"),
                                subtitle: Text(
                                    "This app was made by 5 students for a uni project, we hope you'll like it !"),
                                leading: Icon(
                                  Icons.group,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Creation date"),
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
                            children: const [
                              ListTile(
                                title: Text("Roles"),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("Jules"),
                                subtitle: Text("Front-End design \nDatabase"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Alexandre"),
                                subtitle: Text(
                                    "Screen mockups \nForms \nBackend"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Louis T."),
                                subtitle: Text("Was to supposed to make themes"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Louis C."),
                                subtitle: Text(
                                    "Screen mockups \nFont-End forms"),
                                leading: Icon(
                                  Icons.android_rounded,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              ListTile(
                                title: Text("Yannis"),
                                subtitle: Text("Front-End design"),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
