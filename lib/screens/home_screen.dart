import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/trip_service.dart';
import '../services/connectivity_service.dart';
import '../models/trip_model.dart';
import 'add_trip_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _connectivityService = ConnectivityService();
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectivityService.onConnectivityChanged.listen((isOnline) {
      if (mounted) {
        setState(() {
          _isOnline = isOnline;
        });
      }
    });
    
    // Initialize trips
    _initializeTrips();
  }

  Future<void> _checkConnectivity() async {
    final isOnline = await _connectivityService.isConnected;
    if (mounted) {
      setState(() {
        _isOnline = isOnline;
      });
    }
  }

  Future<void> _initializeTrips() async {
    final userId = context.read<AuthService>().currentUser?.uid;
    if (userId != null) {
      await context.read<TripService>().getTrips(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userId = context.read<AuthService>().currentUser?.uid;
    
    if (userId == null) {
      return Center(child: Text(l10n.errorGeneric));
    }

    return Scaffold(
      body: Column(
        children: [
          if (!_isOnline)
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.wifi_off, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    l10n.offlineMode,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          Expanded(
            child: StreamBuilder<List<TripModel>>(
              stream: context.read<TripService>().tripsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error.toString(),
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _initializeTrips,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final trips = snapshot.data!;

                if (trips.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.noTrips,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.addFirstTrip,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<TripService>().getTrips(userId);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (trip.imageUrl != null)
                              Image.network(
                                trip.imageUrl!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Icon(Icons.error_outline, size: 48),
                                    ),
                                  );
                                },
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          trip.name,
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                      ),
                                      if (!trip.isSynced)
                                        const Tooltip(
                                          message: 'Not synced',
                                          child: Icon(
                                            Icons.sync_problem,
                                            size: 16,
                                            color: Colors.orange,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    trip.description,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            ButtonBar(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // TODO: Implement edit functionality
                                  },
                                  child: const Text('Edit'),
                                ),
                                TextButton(
                                  onPressed: () => context.read<TripService>().deleteTrip(trip.id),
                                  child: Text(l10n.deleteButton),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTripScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 