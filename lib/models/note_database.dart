import 'package:isar/isar.dart';
import 'package:lista/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  static late Isar isar;
  //INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  //List of Notes
  final List<Note> currentNotes = [];

  //CREATE
  Future<void> addNote(String textFromUser) async {
    //create a new note objet
    final newNote = Note()..text = textFromUser;

    //re-read from db
    fetchNotes();

    //save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
  }


}
