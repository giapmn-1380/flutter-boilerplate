import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PHome extends StatelessWidget {
  const PHome({super.key, required this.onPress});

  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), side: BorderSide.none),
          minimumSize: const Size(100, 40),
        ),
        child: Text('hello'.tr()),
      ),
    );
  }
}
