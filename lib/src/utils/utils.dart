import '../database/database_helper.dart';
import '../network/mokodevice/moko_models.dart';
import '../views/devices/Device.dart';

class Utils {

  static void saveDeviceToDatabase(EnquiryDeviceInfoResponse parsedResponse, bool isConnected) {
    final dbHelper = DatabaseHelper.instance;
    final deviceResult = parsedResponse.result;
    final device = Device(
      name: deviceResult.deviceName,
      imageUrl: 'assets/Front_White_BG-1.png.webp',
      isConnected: isConnected,
      deviceType: deviceResult.deviceType,
      deviceId: deviceResult.deviceId,
    );
    dbHelper.updateOrInsert(device);

    if (isConnected) {
      dbHelper.disconnectAllExcept(device);
    }

  }
}
