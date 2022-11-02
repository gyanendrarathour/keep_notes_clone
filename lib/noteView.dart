import 'package:flutter/material.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/editNoteView.dart';
import 'package:keep_notes_clone/model/myNoteModel.dart';

class NoteView extends StatefulWidget {
  Note note;
  NoteView({required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
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
              onPressed: () {},
              icon: Icon(Icons.push_pin_outlined)),
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: Icon(Icons.archive_outlined)),
          IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNoteView(
                              note: widget.note,
                            )));
              },
              icon: Icon(Icons.edit_outlined))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              style: const TextStyle(
                  color: white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.note.content,
              style: const TextStyle(color: white),
            )
          ],
        ),
      ),
    );
  }
}
