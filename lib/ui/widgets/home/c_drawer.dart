import 'package:flutter_boilerplate/config/route/app_route.dart';
import 'package:flutter_boilerplate/config/style/custom_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CDrawer extends HookConsumerWidget {
  const CDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Text(
              'Menu',
              style: TextStyle(color: CustomColor.textPrimary, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('logout'.tr()),
            onTap: () {
              context.go(AppRoute.login.path);
            },
          ),
        ],
      ),
    );
  }

}