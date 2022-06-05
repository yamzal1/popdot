import 'package:flutter/material.dart';
import 'package:popdot/database/firebase_tools.dart';
import 'package:popdot/database/hive_tools.dart';

import '../theme/app_colors.dart';
import 'about.dart';
import 'theme_sounds.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // makeABunchaThemes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Center(
            child: SizedBox(
              height: 80,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          toolbarHeight: 80,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.question_mark,
                color: AppColors.beige,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const About(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: AppColors.white,
        body: SizedBox(
          height: double.infinity,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              buildThemeRow('Your themes', getThemes(), false),
              buildThemeRow('Recent', getThemes(), false),
              buildThemeRow('Made for you', getMadeForYouThemes(), true),
            ],
          ),
        ),
      ),
    );
  }

  Column buildThemeRow(title, method, isBaseTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 150,
          child: FutureBuilder<List>(
            initialData: const [],
            future: method,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data != null) {
                      JukeboxTheme theme =
                          (snapshot.data?[index] as JukeboxTheme);

                      return buildThemeCard(
                          theme.title, theme.image, isBaseTheme);
                    } else {
                      return const Align(
                        alignment: Alignment.center,
                        child: Text('oops'),
                      );
                    }
                  },
                );
              } else {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      width: 150,
                      height: 150,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    print('');
                                  },
                                ),
                              ),
                            ),
                            const Align(
                              child: Icon(
                                Icons.add,
                                size: 50.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Container buildThemeCard(title, backgroundImage, isBaseTheme) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0),
      width: 150,
      height: 150,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Ink.image(
              image: Image.asset('assets/images/' + backgroundImage).image,
              colorFilter:
                  const ColorFilter.mode(AppColors.darkMole, BlendMode.color),
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                        title: title,
                        isBaseTheme: isBaseTheme,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
