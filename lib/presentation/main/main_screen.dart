import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:flutter_note_app/presentation/main/components/note_item.dart';
import 'package:flutter_note_app/presentation/main/main_ui_event.dart';
import 'package:flutter_note_app/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your note',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          )
        ],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isSaved = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNoteScreen()),
          );

          if (isSaved != null && isSaved) {
            viewModel.onEvent(const MainUiEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: state.notes
              .map(
                (note) => GestureDetector(
                  onTap: () async {
                    bool? isSaved = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddEditNoteScreen(
                          note: note,
                        ),
                      ),
                    );

                    if (isSaved != null && isSaved) {
                      viewModel.onEvent(const MainUiEvent.loadNotes());
                    }
                  },
                  child: NoteItem(
                    note: note,
                    onDeleteTap: () {
                      viewModel.onEvent(MainUiEvent.deleteNote(note));

                      final snackBar = SnackBar(
                        content: const Text('노트가 삭제되었습니다.'),
                        action: SnackBarAction(
                          label: '취소',
                          onPressed: () {
                            viewModel.onEvent(const MainUiEvent.restoreNote());
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
