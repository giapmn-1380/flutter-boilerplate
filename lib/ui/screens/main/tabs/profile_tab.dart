import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/ui/widgets/common/dialog/alert_dialog.dart';
import 'package:flutter_boilerplate/view_models/auth/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('profile'.tr())),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 48),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('logout'.tr()),
            onTap: () => showAlertDialog(
              context: context,
              title: 'logout'.tr(),
              content: 'logout_confirm'.tr(),
              positiveActionTitle: 'ok'.tr(),
              negativeActionTitle: 'cancel'.tr(),
              negativeActionPressed: () {},
              positiveActionPressed: () {
                // Logout -> redirect của router tự đưa về AuthStack.
                ref.read(authControllerProvider.notifier).logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
