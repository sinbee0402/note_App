import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/domain/util/order_type.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetNotesUseCase {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<Note>> call(NoteOrder noteOrder) async {
    List<Note> notes = await repository.getNotes();

    switch (noteOrder) {
      case NoteOrderTitle(:final orderType):
        switch (orderType) {
          case Ascending():
            notes.sort((a, b) => a.title.compareTo(b.title));
          case Descending():
            notes.sort((a, b) => -a.title.compareTo(b.title));
        }
      case NoteOrderDate(:final orderType):
        switch (orderType) {
          case Ascending():
            notes.sort((a, b) => a.timestamp.compareTo(b.timestamp));
          case Descending():
            notes.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
        }
      case NoteOrderColor(:final orderType):
        switch (orderType) {
          case Ascending():
            notes.sort((a, b) => a.color.compareTo(b.color));
          case Descending():
            notes.sort((a, b) => -a.color.compareTo(b.color));
        }
    }

    return notes;
  }
}
