import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popdot/database/firebase_tools.dart';
import 'package:popdot/database/hive_tools.dart';
import 'package:popdot/pages/theme_sounds.dart';

import '../theme/app_colors.dart';
import 'about.dart';

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
                if (title != 'Recent') {
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
                                    onTap: () async {
                                      var picked = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);

                                      uploadFile('upload_test.jpg', 'images',
                                          await picked?.readAsBytes());
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
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Your themes will appear here'),
                    ),
                  );
                }
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
            FutureBuilder<String>(
              future: getImageURL(backgroundImage),
              builder: (context, snapshot) {
                Widget child;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  child = const CircularProgressIndicator(
                    key: ValueKey(0),
                  );
                } else {
                  child = Ink.image(
                    key: const ValueKey(1),
                    // image: Image.asset('assets/images/' + backgroundImage).image,
                    image: NetworkImage(snapshot.data as String),
                    colorFilter: const ColorFilter.mode(
                        AppColors.darkMole, BlendMode.color),
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
                  );
                }

                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: child,
                );
              },
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

  animateLoading() {}
}
