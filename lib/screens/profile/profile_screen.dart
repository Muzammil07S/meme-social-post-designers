// PERSON 1: Profile with SQLite Design Count
import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/design.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _name = TextEditingController(text: 'Muzammil (Lead Developer)');
  final _bio = TextEditingController(text: 'CSC303 Mobile App Developer | Meme Creator');

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Design>>(
              future: DatabaseHelper.instance.getDesigns(),
              builder: (context, snapshot) {
                final count = snapshot.data?.length ?? 0;
                return Center(
                  child: Text(
                    'Total Designs in Database: $count',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'User Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bio,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Bio'),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile saved: ${_name.text}'))),
              label: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
