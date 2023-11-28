import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class MenuTile extends StatelessWidget {
  final String title;
  final Widget linkedPage;

  const MenuTile({super.key, required this.title, required this.linkedPage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: this,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            child: linkedPage,
          ),
          );
        });
  }
}
