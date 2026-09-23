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
      body: ListView.separated(
        itemCount: users.length,

        // Build each user
        itemBuilder: (context, index) {
          final user = users[index];

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

            // Three-dot popup menu
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'view') {
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
                }

                if (value == 'delete') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Delete ${user["fullName"]}",
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
                }
              },

              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'favorite',
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Add to favorite'),
                  )
                ),
                PopupMenuItem(
                  value: 'block',
                  child: ListTile(
                    leading: Icon(Icons.block),
                    title: Text('Block this user'),
                  )
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete this user'),
                  )
                )
              ],
            ),

            // Clicking the user itself still shows the SnackBar
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
        },

        // Separator between users
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            thickness: 1,
          );
        },
      ),
    );
  }
}