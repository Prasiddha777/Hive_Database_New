import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:hive_todo/boxes/boxes.dart';
import 'package:hive_todo/models/notes_model.dart';
//hive_flutter make listenable
import 'package:hive_flutter/hive_flutter.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  //final controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Hive Notes',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        //listenable listens value in real time,
        valueListenable: Boxes.getData().listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              //converting data to list form
              var data = value.values.toList().cast<NotesModel>();
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index].title.toString()),
                      Text(data[index].description.toString()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAlertDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //alertDaiglog
  Future<void> _showAlertDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                //
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final data = NotesModel(
                    title: _titleController.text,
                    description: _descController.text);
                final box = Boxes.getData();
                //adding data
                box.add(data);
                //yo save garnu mildena yedi extends garey xaena vani
                data.save();
                print(box);
                _titleController.clear();
                _descController.clear();

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
