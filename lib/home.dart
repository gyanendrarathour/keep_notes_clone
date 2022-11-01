import 'dart:ui';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/createNoteView.dart';
import 'package:keep_notes_clone/noteView.dart';
import 'package:keep_notes_clone/searchPage.dart';
import 'package:keep_notes_clone/services/db.dart';
import 'package:keep_notes_clone/sideMenuBar.dart';

import 'model/myNoteModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<Note> notesList = [];
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String note =
      'This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note';
  String note1 =
      'This is Note This is Note This is Note This is Note This is Note';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // createEntry(Note(
    //     pin: false,
    //     title: "title",
    //     content: "da",
    //     createdTime: "DateTime.now()"));
    getAllNotes();
  }

  Future createEntry(Note note) async {
    await NotesDatabase.instance.insertEntry(note);
  }

  Future getAllNotes() async {
    this.notesList = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  Future getOneNote(int id) async {
    await NotesDatabase.instance.readOneNote(id);
  }

  Future updateOneNote(Note note) async {
    await NotesDatabase.instance.updateNote(note);
  }

  Future deleteOneNote(Note note) async {
    await NotesDatabase.instance.deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: bgColor,
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNoteView()));
              },
              backgroundColor: cardColor,
              child: const Icon(
                Icons.add_outlined,
                size: 30,
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            drawer: const SideMenu(),
            backgroundColor: bgColor,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: cardColor,
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      _drawerKey.currentState!.openDrawer();
                                    },
                                    child: const Icon(
                                      Icons.menu,
                                      color: white,
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchView())),
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Search Your Notes',
                                            style: TextStyle(
                                                color: white.withOpacity(0.5),
                                                fontSize: 15),
                                          )
                                        ]),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.grid_view,
                                      color: white,
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: white,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    NoteSectionAll(),
                    NoteListSection()
                  ],
                ),
              ),
            )),
          );
  }

  // Create Widget of Note Section
  Widget NoteSectionAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                'All (Staggered Grid View)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: white.withOpacity(0.5),
                    fontSize: 12),
              )
            ],
          ),
        ),
        MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notesList.length,
          shrinkWrap: true,
          crossAxisCount: 2,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteView(
                              note: notesList[index],
                            )));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notesList[index].title,
                      style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      notesList[index].content.length > 150
                          ? '${notesList[index].content.substring(0, 150)}...'
                          : notesList[index].content,
                      style: const TextStyle(color: white),
                    ),
                    Text(
                      '${notesList[index].id}',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  // Create Widget of List Section
  Widget NoteListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                'ALL (List View)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: white.withOpacity(0.5),
                    fontSize: 12),
              )
            ],
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'heading',
                      style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      index.isEven
                          ? note.length > 150
                              ? '${note.substring(0, 150)}...'
                              : note
                          : note1,
                      style: const TextStyle(color: white),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
