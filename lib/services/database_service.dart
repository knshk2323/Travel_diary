import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/trip_model.dart';

class DatabaseService {
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'travel_diary.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE trips(
            id TEXT PRIMARY KEY,
            userId TEXT NOT NULL,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            imageUrl TEXT,
            createdAt INTEGER NOT NULL,
            updatedAt INTEGER NOT NULL,
            isSynced INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<void> insertTrip(TripModel trip) async {
    final db = await database;
    await db.insert(
      'trips',
      {
        'id': trip.id,
        'userId': trip.userId,
        'name': trip.name,
        'description': trip.description,
        'imageUrl': trip.imageUrl,
        'createdAt': trip.createdAt.millisecondsSinceEpoch,
        'updatedAt': trip.updatedAt.millisecondsSinceEpoch,
        'isSynced': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TripModel>> getTrips(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'trips',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => TripModel.fromMap({
      ...map,
      'createdAt': DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      'updatedAt': DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    })).toList();
  }

  Future<void> deleteTrip(String id) async {
    final db = await database;
    await db.delete(
      'trips',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TripModel>> getUnsyncedTrips() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'trips',
      where: 'isSynced = ?',
      whereArgs: [0],
    );

    return maps.map((map) => TripModel.fromMap({
      ...map,
      'createdAt': DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      'updatedAt': DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    })).toList();
  }

  Future<void> markTripAsSynced(String id) async {
    final db = await database;
    await db.update(
      'trips',
      {'isSynced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 