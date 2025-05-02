import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  final Function(ThemeMode) onThemeChanged;

  const SettingsPage({
    Key? key,
    required this.onLocaleChanged,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showDeveloperInfo = false;
  ThemeMode _currentTheme = ThemeMode.system;
  String _currentLanguage = 'kk';

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
            subtitle: Text(_currentLanguage),
            onTap: () {
              _showLanguageDialog(context, local);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(local.theme),
            trailing: DropdownButton<ThemeMode>(
              value: _currentTheme,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: const Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: const Text('Dark'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: const Text('System Default'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  _changeTheme(value);
                }
              },
            ),
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
          const SizedBox(height: 20), // Add spacing before buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
                child: Text(local.back),
              ),
              ElevatedButton(
                onPressed: () {
                  // Save actions can be defined here
                  // You can save the settings or perform an action
                },
                child: Text(local.save),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, AppLocalizations local) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(local.selectLanguage),
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Kazakh'),
                  onTap: () => _changeLanguage('kk'),
                ),
                ListTile(
                  title: const Text('Russian'),
                  onTap: () => _changeLanguage('ru'),
                ),
                ListTile(
                  title: const Text('English'),
                  onTap: () => _changeLanguage('en'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _changeLanguage(String langCode) {
    setState(() {
      _currentLanguage = langCode;
      widget.onLocaleChanged(Locale(langCode));
    });
    Navigator.pop(context);
  }

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _currentTheme = themeMode;
      widget.onThemeChanged(themeMode);
    });
  }
}