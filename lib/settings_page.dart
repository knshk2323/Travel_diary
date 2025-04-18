import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showDeveloperInfo = false;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.settingsTitle),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(local.appName),
            subtitle: const Text('v1.0.0'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(local.currentLanguage),
            subtitle: Text(Localizations.localeOf(context).languageCode),
          ),
          const Divider(),
          SwitchListTile(
            title: Text(local.showDeveloperInfo),
            value: _showDeveloperInfo,
            onChanged: (value) {
              setState(() {
                _showDeveloperInfo = value;
              });
            },
            secondary: const Icon(Icons.person),
          ),
          if (_showDeveloperInfo)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                local.developers,
                style: const TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
