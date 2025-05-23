import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.themeTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text(l10n.systemTheme),
                        icon: const Icon(Icons.brightness_auto),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text(l10n.lightTheme),
                        icon: const Icon(Icons.light_mode),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text(l10n.darkTheme),
                        icon: const Icon(Icons.dark_mode),
                      ),
                    ],
                    selected: {settings.themeMode},
                    onSelectionChanged: (Set<ThemeMode> newSelection) {
                      settings.updateTheme(newSelection.first);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.languageTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'en',
                        label: Text('English'),
                      ),
                      ButtonSegment(
                        value: 'es',
                        label: Text('Español'),
                      ),
                      ButtonSegment(
                        value: 'fr',
                        label: Text('Français'),
                      ),
                    ],
                    selected: {settings.locale.languageCode},
                    onSelectionChanged: (Set<String> newSelection) {
                      settings.updateLocale(newSelection.first);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: Text(l10n.versionLabel),
              subtitle: const Text('1.0.0'),
            ),
          ),
          if (!context.watch<AuthService>().currentUser!.isGuest) ...[
            const SizedBox(height: 32),
            FilledButton.tonal(
              onPressed: () async {
                await context.read<AuthService>().signOut();
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.logoutButton),
              ),
            ),
          ],
        ],
      ),
    );
  }
} 