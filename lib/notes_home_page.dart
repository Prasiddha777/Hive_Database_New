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
                      Row(
                        children: [
                          Text(
                            data[index].title.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              delete(data[index]);
                            },
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //edit
                          InkWell(
                            onTap: () {
                              _editNotes(
                                  data[index],
                                  data[index].title.toString(),
                                  data[index].description.toString());
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                      // Text(data[index].title.toString()),
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

  //delete fun
  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  //delete fun
  void edit(NotesModel notesModel) async {
    await notesModel.delete();
  }

  //edit
  Future<void> _editNotes(
      NotesModel notesModel, String title, String descripition) async {
    _titleController.text = title.toString();
    _descController.text = descripition.toString();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Notes'),
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
              onPressed: () async {
                notesModel.title = _titleController.text.toString();
                notesModel.description = _descController.text.toString();
                notesModel.save();
                Navigator.pop(context);
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
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
