import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popdot/database/firebase_tools.dart';
import 'package:popdot/database/hive_tools.dart';
import 'package:popdot/pages/theme_form.dart';
import 'package:popdot/pages/theme_sounds.dart';

import '../theme/app_colors.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool useMaterial3 = true;
  bool useLightMode = true;

  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    // makeABunchaThemes();

    themeData = updateThemes(useMaterial3, useLightMode);
  }

  ThemeData updateThemes(bool useMaterial3, bool useLightMode) {
    return ThemeData(
      useMaterial3: useMaterial3,
      brightness: useLightMode ? Brightness.light : Brightness.dark,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onDoubleTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext cxt) {
                    return const AlertDialog(
                      content: ThemeForm(),
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      backgroundColor: AppColors.white,
                    );
                  },
                );
              },
              child: SizedBox(
                height: 80,
                child: Image.asset('assets/images/logo.png'),
              ),
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
                if (title != 'Recent' && title != 'Made for you') {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
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
                        );
                      } else {
                        if (snapshot.data != null) {
                          JukeboxTheme theme =
                              (snapshot.data?[index - 1] as JukeboxTheme);

                          return buildThemeCard(theme.title, theme.image,
                              theme.description, isBaseTheme);
                        } else {
                          return const Align(
                            alignment: Alignment.center,
                            child: Text('oops'),
                          );
                        }
                      }
                    },
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data != null) {
                        JukeboxTheme theme =
                            (snapshot.data?[index] as JukeboxTheme);

                        return buildThemeCard(theme.title, theme.image,
                            theme.description, isBaseTheme);
                      } else {
                        return const Align(
                          alignment: Alignment.center,
                          child: Text('oops'),
                        );
                      }
                    },
                  );
                }
              } else {
                if (title != 'Recent' && title != 'Made for you') {
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

  Container buildThemeCard(title, backgroundImage, description, isBaseTheme) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    titleController.text = title;
    descriptionController.text = description;

    var newImage = backgroundImage;
    var currentTitle = title;
    var newTitle = title;

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
                      onLongPress: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 32.0, bottom: 32.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: Stack(
                                              children: [
                                                Ink.image(
                                                  image: NetworkImage(
                                                      snapshot.data as String),
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          AppColors.darkMole,
                                                          BlendMode.color),
                                                  fit: BoxFit.cover,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var picked =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);

                                                      uploadFile(
                                                          'upload_test.jpg',
                                                          'images',
                                                          await picked
                                                              ?.readAsBytes());
                                                    },
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Icon(
                                                      Icons.edit_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 64.0,
                                              right: 64.0,
                                              top: 16.0),
                                          child: TextField(
                                            onChanged: (value) {
                                              newTitle = value;
                                            },
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                              labelText: 'Title',
                                              suffixIcon:
                                                  Icon(Icons.edit_outlined),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 64.0,
                                              right: 64.0,
                                              top: 16.0,
                                              bottom: 16.0),
                                          child: TextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            controller: descriptionController,
                                            decoration: const InputDecoration(
                                              labelText: 'Description',
                                              suffixIcon:
                                                  Icon(Icons.edit_outlined),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 2,
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Material(
                                                        color: Colors.red,
                                                        child: InkWell(
                                                          onTap: () {
                                                            updateTheme(
                                                                title,
                                                                titleController
                                                                    .text,
                                                                descriptionController
                                                                    .text,
                                                                newImage);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.delete_outlined,
                                                        color: Colors.white,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 2,
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Material(
                                                        color: Colors.blue,
                                                        child: InkWell(
                                                          onTap: () => {
                                                            updateTheme(
                                                                title,
                                                                titleController
                                                                    .text,
                                                                descriptionController
                                                                    .text,
                                                                newImage)
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
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

  saveTheme(title, newTitle, description, image) {
    updateTheme(title, newTitle, description, image);
  }
}
