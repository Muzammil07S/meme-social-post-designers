// PERSON 3: About
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About App')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_emotions, size: 48, color: Colors.deepPurple),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meme / Social Post Designer',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Version 1.0.0+1', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Divider(height: 32),
            Text(
              'Course Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 8),
            Text('CSC303 - Mobile Application Development\nCOMSATS University Islamabad'),
            SizedBox(height: 20),
            Text(
              'Development Team',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 8),
            Text('project of Mobile app development'),
          ],
        ),
      ),
    );
  }
}
