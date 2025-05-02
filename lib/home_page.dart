import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'about_page.dart';
import 'settings_page.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _trips = [
    {
      'title': 'Kazakhstan Journey',
      'desc': 'Hiked in the Almaty mountains and admired breathtaking landscapes.',
      'image': 'https://pfst.cf2.poecdn.net/base/image/e0e454692ee226117f0da0281c339e746c1b578cba597430b3a2dc68f7a74c58?w=1024&h=768&pmaid=343430738'
    },
    {
      'title': 'Paris Getaway',
      'desc': 'Visited Eiffel Tower and tasted amazing pastries!',
      'image': 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.homeTitle),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _trips.length,
        itemBuilder: (context, index) {
          final trip = _trips[index];

          return Dismissible(
            key: Key(trip['title']!),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                _trips.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${trip['title']} ${local.tripDeleted}'),
                  action: SnackBarAction(
                    label: local.undo,
                    onPressed: () {
                      setState(() {
                        _trips.insert(index, trip);
                      });
                    },
                  ),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      trip['image']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip['title']!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          trip['desc']!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTrip = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTripScreen()),
          );

          if (newTrip != null) {
            setState(() {
              _trips.add(newTrip);
            });
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}