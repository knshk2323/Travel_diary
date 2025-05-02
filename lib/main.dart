import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_page.dart';
import 'about_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const TravelDiaryApp());
}

class TravelDiaryApp extends StatefulWidget {
  const TravelDiaryApp({super.key});

  @override
  State<TravelDiaryApp> createState() => _TravelDiaryAppState();
}

class _TravelDiaryAppState extends State<TravelDiaryApp> {
  Locale _locale = const Locale('kk');
  ThemeMode _themeMode = ThemeMode.system;

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Diary',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.teal,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.teal,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: _themeMode,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('kk'),
      ],
      locale: _locale,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/about': (context) => const AboutPage(),
        '/settings': (context) => SettingsPage(
          onLocaleChanged: _setLocale,
          onThemeChanged: _setThemeMode,
        ),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AboutPage(),
    SettingsPage(
      onLocaleChanged: (locale) {
        // Handle locale change here
      },
      onThemeChanged: (themeMode) {
        // Handle theme change here
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // Navigate to Settings page if the index is 2
            if (_currentIndex == 2) {
              Navigator.pushNamed(context, '/settings');
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: local.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: local.navAbout,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: local.navSettings,
          ),
        ],
      ),
    );
  }
}

// Adding trip screen
class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Trip')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validate the image URL
                    String imageUrl = _imageUrlController.text;
                    if (imageUrl.isEmpty || !Uri.tryParse(imageUrl)!.hasScheme == true) {
                      // If the URL is invalid, use the default image URL
                      imageUrl = "https://images.unsplash.com/photo-1454117096348-e4abbeba002c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
                    }

                    final newTrip = {
                      'title': _titleController.text,
                      'desc': _descController.text,
                      'image': imageUrl,
                    };
                    Navigator.pop(context, newTrip);
                  }
                },
                child: const Text('Add Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}