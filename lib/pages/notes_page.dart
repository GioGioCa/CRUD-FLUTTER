import 'package:flutter/material.dart';
import 'package:lista/models/note.dart';
import 'package:lista/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //Text controller to access what the user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //Fetch existing notes
    readNotes();
  }

  //Create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //Create button
          MaterialButton(
            onPressed: () {
              //Add to db
              context.read<NoteDatabase>().addNote(textController.text);

              //Clear controller
              textController.clear();

              //Pop up dialog
              Navigator.pop(context);
            },
            child: const Text("Create"),
          )
        ],
      ),
    );
  }

  //Read a note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //Update a note
  void updateNote(Note note) {
    //Pre-fill the current note text
    textController.text = note.text;

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          //Update button
          MaterialButton(onPressed: () {
            //Update note in db
            context.read<NoteDatabase>().updateNote(note.id, textController.text);
            //Clear the controller
            textController.clear();
            //pop-up dialog box
            Navigator.pop(context);
          },
          child: const Text("Update"),
          )
          
        ],
      ),
      );
  }

  //Delete a note

  @override
  Widget build(BuildContext context) {
    //Note db
    final noteDatabase = context.watch<NoteDatabase>();

    //Current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: currentNotes.length,
          itemBuilder: (context, index) {
            //get individual note
            final note = currentNotes[index];

            //list tile ui
            return ListTile(
              title: Text(note.text),
              trailing: Row(
                mainAxisAlignment: MainAxisSize.min,
                children: [
                  //Edit button

                  //Delete button
                ],
              ),
            );
          }),
    );
  }
}
