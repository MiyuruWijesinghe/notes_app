import 'dart:convert';
import 'package:notes_app/models/api_response.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/models/note_insert.dart';

class NotesService {
  static const API = 'https://word-quiz-app-backend.herokuapp.com';
  static const headers = {
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/category/all').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred buhaha'));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/category/'+noteID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<Note>(error: true, errorMessage: 'An error occurred buhaha'));
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(API + '/category/MiyuruW/save', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred buhaha'));
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(API + '/category/MiyuruW/'+noteID, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred buhaha'));
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(API + '/category/'+noteID).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred buhaha'));
  }
}
