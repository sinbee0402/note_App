import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';

import 'package:flutter_note_app/domain/use_case/use_cases.dart';
import 'package:flutter_note_app/presentation/main/main_state.dart';
import 'package:flutter_note_app/presentation/main/main_ui_event.dart';

class MainViewModel with ChangeNotifier {
  final UseCases useCases;

  MainState _state = const MainState();
  MainState get state => _state;

  Note? _recentlyDeletedNote;

  MainViewModel(this.useCases) {
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
      case ChangeOrder(:final noteOrder):
        _state = state.copyWith(
          noteOrder: noteOrder,
        );
        _loadNotes();
      case ToggleOrderSection():
        _state = state.copyWith(
          isOrderSectionVisible: !state.isOrderSectionVisible,
        );
        notifyListeners();
    }
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes(state.noteOrder);
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNote(note);
    _recentlyDeletedNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      await useCases.addNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      _loadNotes();
    }
  }
}
