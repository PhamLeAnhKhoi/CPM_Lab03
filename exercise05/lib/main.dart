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

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  // Local copy of the users list
  late List usersList;

  // Store IDs of favorite users
  final Set<int> favoriteUsers = {};

  // Store IDs of blocked users
  final Set<int> blockedUsers = {};

  @override
  void initState() {
    super.initState();

    // Make a copy so deleting users does not modify users.dart
    usersList = List.from(users);
  }

  // Show SnackBar
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.orange,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Listview')),
      ),

      body: ListView.separated(
        itemCount: usersList.length,

        itemBuilder: (context, index) {
          final user = usersList[index];

          final int userId = user["id"];

          // Check current state
          final bool isFavorite = favoriteUsers.contains(userId);
          final bool isBlocked = blockedUsers.contains(userId);

          return Opacity(
            // Blocked users are greyed out
            opacity: isBlocked ? 0.4 : 1.0,

            child: ListTile(
              leading: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://randomuser.me/api/portraits/men/$userId.jpg',
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

              // Right side of the ListTile
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Heart icon for favorite users
                  if (isFavorite)
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),

                  // Three-dot popup menu
                  PopupMenuButton<String>(
                    onSelected: (value) {

                      // ADD TO FAVORITE
                      if (value == 'favorite') {
                        setState(() {
                          favoriteUsers.add(userId);
                        });
                      }

                      // REMOVE FROM FAVORITE
                      if (value == 'unfavorite') {
                        setState(() {
                          favoriteUsers.remove(userId);
                        });
                      }

                      // BLOCK USER
                      if (value == 'block') {
                        setState(() {
                          blockedUsers.add(userId);
                        });
                      }

                      // UNBLOCK USER
                      if (value == 'unblock') {
                        setState(() {
                          blockedUsers.remove(userId);
                        });
                      }

                      // DELETE USER
                      if (value == 'delete') {
                        setState(() {

                          // Remove from the list
                          usersList.removeAt(index);

                          // Also remove any stored state
                          favoriteUsers.remove(userId);
                          blockedUsers.remove(userId);
                        });
                      }
                    },

                    itemBuilder: (context) => [

                      // Favorite / Remove Favorite
                      PopupMenuItem(
                        value: isFavorite
                            ? 'unfavorite'
                            : 'favorite',

                        child: ListTile(
                          leading: Icon(
                            isFavorite
                                ? Icons.favorite_border
                                : Icons.favorite,
                          ),

                          title: Text(
                            isFavorite
                                ? 'Remove from favorite'
                                : 'Add to favorite',
                          ),
                        ),
                      ),

                      // Block / Unblock
                      PopupMenuItem(
                        value: isBlocked
                            ? 'unblock'
                            : 'block',

                        child: ListTile(
                          leading: Icon(
                            isBlocked
                                ? Icons.lock_open
                                : Icons.block,
                          ),

                          title: Text(
                            isBlocked
                                ? 'Unblock this user'
                                : 'Block this user',
                          ),
                        ),
                      ),

                      // Delete
                      const PopupMenuItem(
                        value: 'delete',

                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete this user'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Clicking the user itself
              onTap: () {
                showMessage(
                  "You've clicked on ${user["fullName"]}",
                );
              },
            ),
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