import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'main_ui_event.freezed.dart';

@freezed
sealed class MainUiEvent<T> with _$MainUiEvent<T> {
  const factory MainUiEvent.loadNotes() = LoadNotes;
  const factory MainUiEvent.deleteNote(Note note) = DeleteNote;
  const factory MainUiEvent.restoreNote() = RestoreNote;
  const factory MainUiEvent.changeOrder(NoteOrder noteOrder) = ChangeOrder;
}
