// PERSON 3: About
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meme / Social Post Designer',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('CSC303 - Mobile Application Development\nCOMSATS University Islamabad'),
            SizedBox(height: 12),
            Text('Team: Person 1, Person 2, Person 3  (apne naam likho)'),
          ],
        ),
      ),
    );
  }
}
