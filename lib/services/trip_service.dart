import 'dart:async';
import '../models/trip_model.dart';
import 'database_service.dart';
import 'connectivity_service.dart';

class TripService {
  final _databaseService = DatabaseService();
  final _connectivityService = ConnectivityService();
  final _tripController = StreamController<List<TripModel>>.broadcast();
  bool _isInitialized = false;

  Stream<List<TripModel>> get tripsStream => _tripController.stream;

  TripService() {
    // Listen to connectivity changes to trigger sync
    _connectivityService.onConnectivityChanged.listen((isConnected) {
      if (isConnected) {
        syncTrips();
      }
    });
  }

  Future<void> createTrip({
    required String userId,
    required String name,
    required String description,
    String? imageUrl,
  }) async {
    final trip = TripModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      name: name,
      description: description,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Always save to local database first
    await _databaseService.insertTrip(trip);

    // Try to sync immediately if online
    if (await _connectivityService.isConnected) {
      await syncTrips();
    }

    // Notify listeners
    final trips = await _databaseService.getTrips(userId);
    _tripController.add(trips);
  }

  Future<List<TripModel>> getTrips(String userId) async {
    // Always get from local database first
    final localTrips = await _databaseService.getTrips(userId);
    
    // Only add to stream if we haven't initialized yet or if we're refreshing
    if (!_isInitialized || await _connectivityService.isConnected) {
      _tripController.add(localTrips);
      _isInitialized = true;
    }

    // Try to sync if online
    if (await _connectivityService.isConnected) {
      await syncTrips();
      final updatedTrips = await _databaseService.getTrips(userId);
      _tripController.add(updatedTrips);
      return updatedTrips;
    }

    return localTrips;
  }

  Future<void> deleteTrip(String tripId) async {
    // Delete from local database
    await _databaseService.deleteTrip(tripId);

    // Try to sync if online
    if (await _connectivityService.isConnected) {
      // TODO: Implement online delete
      // For now, we'll just handle local deletion
    }
  }

  Future<void> syncTrips() async {
    try {
      final unsyncedTrips = await _databaseService.getUnsyncedTrips();
      
      for (final trip in unsyncedTrips) {
        // TODO: Implement actual API calls here
        // For now, we'll just mark them as synced
        await _databaseService.markTripAsSynced(trip.id);
      }
    } catch (e) {
      print('Error syncing trips: $e');
    }
  }

  void dispose() {
    _tripController.close();
  }
} 