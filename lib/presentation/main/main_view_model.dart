import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/main/main_state.dart';
import 'package:flutter_note_app/presentation/main/main_ui_event.dart';

class MainViewModel with ChangeNotifier {
  final NoteRepository repository;

  MainState _state = MainState();
  MainState get state => _state;

  Note? _recentlyDeletedNote;

  MainViewModel(this.repository) {
    _loadNotes();
  }

  void onEvent(MainUiEvent event) {
    // 26 첫번째 viewModel 작성
    switch (event) {
      case LoadNotes():
        _loadNotes;
      case DeleteNote():
        _deleteNote;
      case RestoreNote():
        _restoreNote;
    }
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await repository.getNotes();
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await repository.deleteNote(note);
    _recentlyDeletedNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      await repository.insertNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      _loadNotes();
    }
  }
}
