import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.travel_explore,
                size: 100,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Travel Diary',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Features',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const _FeatureItem(
              icon: Icons.person,
              title: 'User Accounts',
              description: 'Create an account to save and sync your trips across devices',
            ),
            const _FeatureItem(
              icon: Icons.cloud_off,
              title: 'Offline Mode',
              description: 'Access and modify your trips even without internet connection',
            ),
            const _FeatureItem(
              icon: Icons.language,
              title: 'Multiple Languages',
              description: 'Available in English, Spanish, and French',
            ),
            const _FeatureItem(
              icon: Icons.brightness_6,
              title: 'Theme Support',
              description: 'Choose between light, dark, or system theme',
            ),
            const SizedBox(height: 32),
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Travel Diary is your personal travel companion, helping you capture and remember all your adventures. '
              'Create detailed trip entries with photos, keep track of your experiences, and never lose a memory.',
            ),
            const SizedBox(height: 32),
            Text(
              'Contact',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'For support or feedback, please contact us at:\n'
              'support@traveldiary.com',
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 