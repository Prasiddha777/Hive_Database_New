import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Hive',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Hive.openBox('prasid'),
              builder: (context, snapshot) {
                return ListTile(
                  title: Text(
                    snapshot.data!.get('name').toString(),
                  ),
                  subtitle: Text(
                    snapshot.data!.get('age').toString(),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      //for updating value
                      snapshot.data!.put('name', 'Prasiddha khadka updated');
                      setState(() {});
                    },
                    icon: Icon(Icons.update),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('prasid');
          box.put('name', 'prasiddha khadka');
          box.put('age', '24');
          box.put('details', {
            'Pro': 'App developer',
            'City': 'Pokhara',
            'Country': 'Nepal',
          });
          print(
            box.get('name'),
          );
          print(
            box.get('age'),
          );
          print(
            box.get('details'),
          );
          print(
            box.get('details')['Pro'],
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
