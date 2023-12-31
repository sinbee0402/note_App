import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:flutter_note_app/presentation/main/components/note_item.dart';
import 'package:flutter_note_app/presentation/main/components/order_section.dart';
import 'package:flutter_note_app/presentation/main/main_ui_event.dart';
import 'package:flutter_note_app/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

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
            onPressed: () {
              viewModel.onEvent(const MainUiEvent.toggleOrderSection());
            },
            icon: const Icon(Icons.sort),
          )
        ],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isSaved = await context.push('/add_note');

          if (isSaved != null && isSaved) {
            viewModel.onEvent(const MainUiEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.isOrderSectionVisible
                  ? OrderSection(
                      noteOrder: state.noteOrder,
                      onOrderChanged: (noteOrder) {
                        viewModel.onEvent(MainUiEvent.changeOrder(noteOrder));
                      },
                    )
                  : Container(),
            ),
            ...state.notes
                .map(
                  (note) => GestureDetector(
                    onTap: () async {
                      bool? isSaved =
                          await context.push('/edit_note', extra: note);

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
                              viewModel
                                  .onEvent(const MainUiEvent.restoreNote());
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
