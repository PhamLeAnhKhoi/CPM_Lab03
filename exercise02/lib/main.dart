import 'package:flutter/material.dart';
import 'users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersPage(),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView(
        children: users.map((user) {
          return ListTile(
            leading: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://randomuser.me/api/portraits/men/${user["id"]}.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person);
                  },
                ),
              ),
            ),
            title: Text(
              user["fullName"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(user["jobTitle"]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "You've clicked on ${user["fullName"]}",
                  ),
                  action: SnackBarAction(
                    label: 'DISMISS',
                    textColor: Colors.orange,
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                          .hideCurrentSnackBar();
                    },
                  ),
                  backgroundColor: Colors.black,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
