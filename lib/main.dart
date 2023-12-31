import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_todo/home_page.dart';
import 'package:hive_todo/models/notes_model.dart';
import 'package:hive_todo/notes_home_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  //initializing the hive database at first
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //registering the adapter
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NotesHomePage(),
    );
  }
}
