import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../views/devices/Device.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'devices';

  static final columnId = '_id';
  static final columnDeviceId = 'deviceId';
  static final columnName = 'name';
  static final columnImageUrl = 'imageUrl';
  static final columnIsConnected = 'isConnected';
  static final columnDeviceType = 'deviceType';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnDeviceId TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnImageUrl TEXT NOT NULL,
            $columnIsConnected INTEGER NOT NULL,
            $columnDeviceType TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Device device) async {
    Database db = await instance.database;
    return await db.insert(table, device.toMap());
  }

  // Update a device if it exists, otherwise insert it
  Future<void> updateOrInsert(Device device) async {
    Database db = await instance.database;
    int updatedRows = await db.update(
      table,
      device.toMap(),
      where: '$columnDeviceId = ?',
      whereArgs: [device.deviceId],
    );

    if (updatedRows == 0) {
      await db.insert(table, device.toMap());
    }
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Device>> queryAllDevices() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Device(
        deviceId: maps[i][columnDeviceId],
        name: maps[i][columnName],
        imageUrl: maps[i][columnImageUrl],
        isConnected: maps[i][columnIsConnected] == 1,
        deviceType: maps[i][columnDeviceType],
      );
    });
  }

  // Update all devices to be disconnected, except for the specified device
  Future<void> disconnectAllExcept(Device device) async {
    Database db = await instance.database;
    await db.update(
      table,
      {'$columnIsConnected': 0},
      where: '$columnDeviceId != ?',
      whereArgs: [device.deviceId],
    );
  }

}