import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> callers = [
    {
      'initials': 'M',
      'name': 'MOM',
      'message':
          'Mom is really worried about you and wants you home immediately',
      'color': Colors.red[200],
    },
    {
      'initials': 'Bf',
      'name': 'Best Friend',
      'message': 'Hey bestfriend let me tell you about my day',
      'color': Colors.brown[400],
    },
    {
      'initials': 'D',
      'name': 'DAD',
      'message': 'Hey, how was your day? Dad is waiting for your response',
      'color': Colors.orange[200],
    },
    {
      'initials': 'L',
      'name': 'Love',
      'message':
          'Hey babe, when do you get home? While I have you on the phone......',
      'color': Colors.green[200],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Caller',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      context.push(RoutePath.newContactScreen.addBasePath);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: callers.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final caller = callers[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    elevation: 0,
                    child: ListTile(
                      tileColor: AppColors.backgroundColor,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: caller['color'],
                        child: Text(
                          caller['initials'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        caller['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(caller['message']),
                      onTap: () {
                        // TODO: Handle tap
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
