import 'package:beemee/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:beemee/models/user.dart' as beemee_user;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<beemee_user.UserModel> _users = []; // Make _users final

  @override
  void initState() {
    super.initState();
    // Load data from API or storage here
    // _users = await fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint('Button pressed');
              },
              child: const Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}