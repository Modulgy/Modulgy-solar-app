

class Device {
  final String name;
  final String deviceId;
  final String imageUrl;
  final bool isConnected;
  final String deviceType;

  Device({required this.name, required this.imageUrl, required this.isConnected, required this.deviceType, required this.deviceId});

  // Convert a Device object into a Map
  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'name': name,
      'imageUrl': imageUrl,
      'isConnected': isConnected ? 1 : 0, // SQLite does not have boolean type
      'deviceType': deviceType,
    };
  }
}