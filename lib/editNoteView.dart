import 'package:flutter/material.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/noteView.dart';
import 'package:keep_notes_clone/services/db.dart';

import 'model/myNoteModel.dart';

class EditNoteView extends StatefulWidget {
  Note note;
  EditNoteView({required this.note});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String newTitle;
  late String newNote;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.newTitle = widget.note.title.toString();
    this.newNote = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () async {
                Note localNewNote = Note(
                    pin: false,
                    title: newTitle,
                    content: newNote,
                    createdTime: 'now',
                    id: widget.note.id);
                await NotesDatabase.instance.updateNote(localNewNote);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteView(note: localNewNote)));
              },
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                initialValue: newTitle,
                cursorColor: white,
                onChanged: (value) {
                  newTitle = value;
                },
                style: TextStyle(fontSize: 25, color: white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Heading',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.8))),
              ),
            ),
            Container(
                height: 300,
                child: Form(
                  child: TextFormField(
                    initialValue: newNote,
                    cursorColor: white,
                    onChanged: (value) {
                      newNote = value;
                    },
                    keyboardType: TextInputType.multiline,
                    minLines: 50,
                    maxLines: null,
                    style: TextStyle(fontSize: 17, color: white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Note',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.8))),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
