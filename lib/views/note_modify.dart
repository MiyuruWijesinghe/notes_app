import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_insert.dart';
import 'package:notes_app/services/notes_service.dart';

class NoteModify extends StatefulWidget {

  final String noteID;
  NoteModify({
    this.noteID
  });

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get service => GetIt.instance<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _iconController = TextEditingController();
  TextEditingController _bgColorController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      service.getNote(widget.noteID)
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        note = response.data;
        _nameController.text = note.name;
        _descriptionController.text = note.description;
        _iconController.text = note.icon;
        _bgColorController.text = note.backgroundColor;
        _imageController.text = note.imageURL;
        _statusController.text = note.status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            Container(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            Container(height: 16),
            TextField(
              controller: _iconController,
              decoration: InputDecoration(hintText: 'Icon'),
            ),
            Container(height: 8),
            TextField(
              controller: _bgColorController,
              decoration: InputDecoration(hintText: 'Background color'),
            ),
            Container(height: 8),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(hintText: 'Image'),
            ),
            Container(height: 8),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(hintText: 'Status'),
            ),
            Container(height: 8),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (isEditing) {
                    setState(() {
                      _isLoading = true;
                    });

                    final note = NoteManipulation(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        icon: _iconController.text,
                        backgroundColor: _bgColorController.text,
                        imageURL: _imageController.text,
                        status: _statusController.text
                    );
                    final result = await service.updateNote(widget.noteID, note);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your note was updated';

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                    )
                        .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  } else {
                    setState(() {
                      _isLoading = true;
                    });

                    final note = NoteManipulation(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        icon: _iconController.text,
                        backgroundColor: _bgColorController.text,
                        imageURL: _imageController.text,
                        status: _statusController.text
                    );
                    final result = await service.createNote(note);

                    setState(() {
                      _isLoading = false;
                    });

                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your note was created';

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                      )
                    .then((data) {
                      if (result.data) {
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
