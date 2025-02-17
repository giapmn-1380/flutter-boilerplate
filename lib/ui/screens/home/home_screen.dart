import 'package:flutter_boilerplate/ui/widgets/home/c_drawer.dart';
import 'package:flutter_boilerplate/ui/widgets/home/c_home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text('home'.tr()),
      ),
      drawer: const CDrawer(),
      body: const CHome(),
    );
  }
}
