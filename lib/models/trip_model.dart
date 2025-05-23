class TripModel {
  final String id;
  final String userId;
  final String name;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;

  TripModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isSynced': isSynced ? 1 : 0,
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      createdAt: map['createdAt'] is DateTime 
          ? map['createdAt'] 
          : DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] is DateTime 
          ? map['updatedAt'] 
          : DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      isSynced: map['isSynced'] == 1,
    );
  }

  TripModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) {
    return TripModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
} 