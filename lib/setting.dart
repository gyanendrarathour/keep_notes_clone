import 'package:flutter/material.dart';
import 'package:keep_notes_clone/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        title: const Text('Settings'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Sync',
                  style: TextStyle(color: white, fontSize: 16),
                ),
                const Spacer(),
                Switch(
                    value: value,
                    onChanged: (switchValue) {
                      setState(() {
                        value = switchValue;
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
