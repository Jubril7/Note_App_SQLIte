import 'package:flutter/material.dart';
import 'package:user_auth/Models/note_model.dart';
import 'package:user_auth/SQLite/sqlite.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create note'),
        actions: [
          IconButton(
          onPressed: () {
            if(formKey.currentState!.validate()) {
              db.createNote(NoteModel(
              noteTitle: title.text, 
              noteContent: content.text, 
              createdAt: DateTime.now().toIso8601String()))
              .whenComplete(() => Navigator.of(context).pop(true));
            }
          },
          icon: const Icon(Icons.check))
        ],
      ),

      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: title,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Title')
                ),
              ),
          
              TextFormField(
                controller: content,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Content is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Content')
                ),
              )
            ]
            ),
        ),
      ),
    );
  }
}