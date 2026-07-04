import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  static const _locales = [
    (locale: Locale('en', 'US'), label: 'English'),
    (locale: Locale('vi', 'VN'), label: 'Tiếng Việt'),
    (locale: Locale('ja', 'JP'), label: '日本語'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr())),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'language'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          for (final item in _locales)
            RadioListTile<Locale>(
              value: item.locale,
              groupValue: context.locale,
              title: Text(item.label),
              onChanged: (locale) {
                if (locale != null) context.setLocale(locale);
              },
            ),
        ],
      ),
    );
  }
}
