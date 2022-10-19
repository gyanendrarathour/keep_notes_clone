import 'package:flutter/material.dart';
import 'package:keep_notes_clone/archiveView.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/setting.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(color: bgColor),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: const Text(
                  'Google Keep',
                  style: TextStyle(
                      color: white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: white.withOpacity(0.3),
              ),
              sectionOne(),
              const SizedBox(
                height: 10,
              ),
              sectionTwo(),
              const SizedBox(
                height: 10,
              ),
              sectionThree()
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionOne() {
    return TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outlined,
              color: white.withOpacity(0.7),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Notes',
              style: TextStyle(fontSize: 18, color: white.withOpacity(0.7)),
            )
          ],
        ));
  }

  Widget sectionTwo() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ArchiveView()));
        },
        child: Row(
          children: [
            Icon(
              Icons.archive_outlined,
              color: white.withOpacity(0.7),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Archive',
              style: TextStyle(fontSize: 18, color: white.withOpacity(0.7)),
            )
          ],
        ));
  }

  Widget sectionThree() {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Settings()));
        },
        child: Row(
          children: [
            Icon(
              Icons.settings_outlined,
              color: white.withOpacity(0.7),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Setting',
              style: TextStyle(fontSize: 18, color: white.withOpacity(0.7)),
            )
          ],
        ));
  }
}
