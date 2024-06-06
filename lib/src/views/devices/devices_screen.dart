import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../database/database_helper.dart';
import 'Device.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future: DatabaseHelper.instance.queryAllDevices(),
      builder: (BuildContext context, AsyncSnapshot<List<Device>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Image.asset(snapshot.data![index].imageUrl),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].deviceType),
                    trailing: Icon(
                      snapshot.data![index].isConnected
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: snapshot.data![index].isConnected
                          ? Colors.green
                          : Colors.red,
                    ));
              });
        } else if (snapshot.hasError) {
          return Center(child: Text(Localized.of(context).failed_to_load_devices));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Localized.of(context).no_devices_found,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  Localized.of(context).please_add_new_device,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
