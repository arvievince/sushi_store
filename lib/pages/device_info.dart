import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:sushi_store/pages/helper/encryption_helpder.dart';

class DeviceInfoSettings extends StatelessWidget {
  DeviceInfoSettings({super.key});

  final deviceInfoPlugin = DeviceInfoPlugin();
  final TextEditingController _deviceActivationField = TextEditingController();
  final TextEditingController _activationKeyField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Device Info"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _buildDeviceInfo(context),
    );
  }

  Widget _buildDeviceInfo(BuildContext context) {
    if (kIsWeb) {
      return const Center(child: Text('Web platform not supported.'));
    }

    Widget deviceInfoWidget;
    if (Platform.isAndroid) {
      deviceInfoWidget = showAndroidInfo();
    } else if (Platform.isIOS) {
      deviceInfoWidget = showIOSInfo();
    } else if (Platform.isWindows) {
      deviceInfoWidget = showWindowsInfo();
    } else {
      deviceInfoWidget = const Center(child: Text('Unsupported platform.'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _activationKeyForm(),
                    TextField(
                      controller: _activationKeyField,
                      decoration: const InputDecoration(
                        labelText: 'Enter activation key',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => checkAndNavigate(context),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
        Expanded(child: deviceInfoWidget),
      ],
    );
  }

  void dispose() {
    _activationKeyField.dispose();
  }

  Widget _activationKeyForm() {
    if (Platform.isWindows) {
      return FutureBuilder<WindowsDeviceInfo>(
        future: deviceInfoPlugin.windowsInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final companyName = "";
            final info = snapshot.data!;
            String deviceId = "";
            if (companyName.isEmpty) {
              deviceId = info.buildNumber.toString();
            } else {
              deviceId = '${info.buildNumber}$companyName';
            }
            return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Builder(
                  builder: (context) {
                    _deviceActivationField.text = deviceId;
                    return TextField(
                      controller: _deviceActivationField,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Device ID',
                        hintText: 'Device ID:',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ));
          }
          return const SizedBox.shrink();
        },
      );
    } else if (Platform.isAndroid) {
      return FutureBuilder<AndroidDeviceInfo>(
        future: deviceInfoPlugin.androidInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final companyName = "";
            final info = snapshot.data!;
            final deviceId = info.model + companyName;
            print('Device ID: $deviceId');
            return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Builder(
                  builder: (context) {
                    _deviceActivationField.text = deviceId;
                    return TextField(
                      controller: _deviceActivationField,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Device ID',
                        hintText: 'Device ID:',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ));
          }
          return const SizedBox.shrink();
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> checkAndNavigate(BuildContext context) async {
    String devicename = _activationKeyField.text.trim();
    String? encryptedDeviceId;
    String companyName = "";

    try {
      if (Platform.isAndroid) {
        final info = await deviceInfoPlugin.androidInfo;
        final bytes = utf8.encode(info.model + companyName);
        final shaDeviceId = sha256.convert(bytes);
        encryptedDeviceId = EncryptHelper.encryptText(shaDeviceId.toString());
        print('Encrypted ID: $encryptedDeviceId');
      } else if (Platform.isIOS) {
        final info = await deviceInfoPlugin.iosInfo;
        encryptedDeviceId =
            EncryptHelper.encryptText(info.identifierForVendor ?? '');
      } else if (Platform.isWindows) {
        final info = await deviceInfoPlugin.windowsInfo;
        final bytes = utf8.encode(info.buildNumber.toString() + companyName);
        final shaDeviceId = sha256.convert(bytes);
        encryptedDeviceId = EncryptHelper.encryptText(shaDeviceId.toString());
      }
    } catch (e) {
      encryptedDeviceId = null;
    }

    if (encryptedDeviceId != null && devicename == encryptedDeviceId) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Activation Successful'),
          content: const Text('The software has been activated. Thank you.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/menupage');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Activation Failed'),
          content: const Text('Activation key did not match. Try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget showWindowsInfo() {
    return FutureBuilder<WindowsDeviceInfo>(
      future: deviceInfoPlugin.windowsInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final info = snapshot.data!;
          final companyName = "";
          final deviceId = info.buildNumber.toString() + companyName;
          final encrypted = EncryptHelper.encryptText(deviceId);
          final decrypted = EncryptHelper.decryptText(encrypted);

          print('Encrypted ID: $encrypted');

          return buildDeviceInfoList([
            ['Computer Name', info.computerName],
            ['Encrypted ID', encrypted],
            ['Decrypted ID', decrypted],
            ['User Name', info.userName],
            ['Build Number', info.buildNumber.toString()],
            ['Cores', info.numberOfCores.toString()],
            ['Memory (MB)', info.systemMemoryInMegabytes.toString()],
            [
              'Windows Version',
              '${info.majorVersion}.${info.minorVersion}.${info.buildNumber}'
            ],
            ['Display Version', info.displayVersion],
            ['Platform ID', info.platformId.toString()],
            ['Product Type', info.productType.toString()],
          ]);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget showAndroidInfo() {
    return FutureBuilder<AndroidDeviceInfo>(
      future: deviceInfoPlugin.androidInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final info = snapshot.data!;
          final companyName = "";
          final deviceId = info.model + companyName;

          // Hash the deviceId with SHA before AES encryption
          final bytes = utf8.encode(deviceId);
          final shaDeviceId = sha256.convert(bytes);
          final encrypted = EncryptHelper.encryptText(shaDeviceId.toString());
          final decrypted = EncryptHelper.decryptText(encrypted);

          print(encrypted);

          return buildDeviceInfoList([
            ['Model', info.model],
            ['Device ID', deviceId],
            ['Encrypted ID', encrypted],
            ['Decrypted ID', decrypted],
          ]);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget showIOSInfo() {
    return FutureBuilder<IosDeviceInfo>(
      future: deviceInfoPlugin.iosInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final info = snapshot.data!;
          final identifier = info.identifierForVendor ?? '';
          final encrypted = EncryptHelper.encryptText(identifier);
          final decrypted = EncryptHelper.decryptText(encrypted);

          return buildDeviceInfoList([
            ['Model', info.model],
            ['Device Name', info.name],
            ['System Name', info.systemName],
            ['System Version', info.systemVersion],
            ['Identifier', identifier],
            ['Encrypted ID', encrypted],
            ['Decrypted ID', decrypted],
            ['Physical Device', info.isPhysicalDevice.toString()],
          ]);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildDeviceInfoList(List<List<String>> items) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: items.map((pair) => item(pair[0], pair[1])).toList(),
      ),
    );
  }

  Widget item(String name, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
