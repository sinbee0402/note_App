import 'package:flutter_note_app/di/di_setup.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/presentation/main/main_screen.dart';
import 'package:flutter_note_app/presentation/main/main_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<MainViewModel>(),
        child: const MainScreen(),
      ),
    ),
    GoRoute(
      path: '/add_note',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<AddEditNoteViewModel>(),
        child: const AddEditNoteScreen(),
      ),
    ),
    GoRoute(
      path: '/edit_note',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<AddEditNoteViewModel>(),
        child: AddEditNoteScreen(note: state.extra! as Note),
      ),
    ),
  ],
);
