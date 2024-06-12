import 'package:flutter/material.dart';
import 'package:navigation_time/features/posts/views/widgets/post_more.dart';
import 'package:navigation_time/features/posts/views/widgets/report.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({super.key});

  @override
  _ModalSheetState createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  int _index = 0;

  void changeIndex(index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(sizeFactor: animation, child: child);
      },
      child: _index == 0
          ? PostMore(selectIndex: changeIndex)
          : Report(selectIndex: changeIndex),
    );
  }
}
