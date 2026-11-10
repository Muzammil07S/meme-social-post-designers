// OWNER: Person 1
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/native_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Dark Mode'),
          secondary: const Icon(Icons.dark_mode),
          value: theme.isDark,
          onChanged: (v) => context.read<ThemeProvider>().toggle(v),
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Show Native Toast (Kotlin)'),
          onTap: () => NativeService.showToast('Hello from Kotlin!'),
        ),
        ListTile(
          leading: const Icon(Icons.phone_android),
          title: const Text('Device Info (Kotlin)'),
          onTap: () async {
            final info = await NativeService.getDeviceInfo();
            if (!context.mounted) return;
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Device Info'),
                content: Text(info),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('OK')),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
