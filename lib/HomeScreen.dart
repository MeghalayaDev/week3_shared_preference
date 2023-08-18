import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Prefernce Example!!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Please give some title',
                    labelText: 'Title *',
                  ),
                ),
                TextFormField(
                  controller: descriptionEditingController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Please give some description',
                    labelText: 'Description *',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print(titleEditingController.text);
                        print(descriptionEditingController.text);

                        saveToSharedPreference();
                        titleEditingController.text = "";
                        descriptionEditingController.text = "";
                      },
                      child: const Text("Save"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        getDraftValues();
                        setState(() {});
                      },
                      child: const Text("Get Draft"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // SizedBox(
            //   height: 300,
            //   child: ListView.builder(
            //       itemCount: todos.length,
            //       itemBuilder: (context, index) {
            //         return ListTile(
            //           title: Text(todos[index].title),
            //           subtitle: Text(todos[index].description),
            //         );
            //       }),
            // ),
          ],
        ),
      ),
    );
  }

  saveToSharedPreference() {
    prefs.setString("title", titleEditingController.text);
    prefs.setString("description", descriptionEditingController.text);
  }

  getDraftValues() {
    titleEditingController.text = prefs.getString("title")!;
    descriptionEditingController.text = prefs.getString("description")!;
  }
}
