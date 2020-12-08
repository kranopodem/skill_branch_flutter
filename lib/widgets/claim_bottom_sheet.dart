import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> list = [
    'adult',
    'harm',
    'bully',
    'spam',
    'copyright',
    'hate'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          list.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Text(list[index].toUpperCase()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
