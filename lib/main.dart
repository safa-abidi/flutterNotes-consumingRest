import 'package:flutter/material.dart';
import 'package:notes_app/services/notes_service.dart';
import 'package:notes_app/views/notes_list.dart';
import 'package:get_it/get_it.dart';

void setUpLocator(){
  GetIt.instance.registerLazySingleton(() => NotesService());
}
void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesList(),
    );
  }
}
