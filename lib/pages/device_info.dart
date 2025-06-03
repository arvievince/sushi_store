import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class DeviceInfoSettings extends StatelessWidget {
  DeviceInfoSettings({super.key});

  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Device Info"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _buildDeviceInfo(),
    );
  }

  Widget _buildDeviceInfo() {
    if (kIsWeb) {
      return const Center(child: Text('Web platform not supported.'));
    }
    if (Platform.isAndroid) {
      return showAndroidInfo();
    } else if (Platform.isIOS) {
      return showIOSInfo();
    } else if (Platform.isWindows) {
      return showWindowsInfo();
    } else {
      return const Center(child: Text('Unsupported platform.'));
    }
  }

  Widget showAndroidInfo() {
    return FutureBuilder<AndroidDeviceInfo>(
      future: deviceInfoPlugin.androidInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          AndroidDeviceInfo info = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                item('Android Model', info.model),
                item('Android Brand', info.brand),
                item('Android Device', info.device),
                item('Android Hardware', info.hardware),
                item('Android Host', info.host),
                item('Android ID', info.id),
                item('Android Is Physical', info.isPhysicalDevice.toString()),
                item('Android SDK Int', info.version.sdkInt.toString()),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget showWindowsInfo() {
    return FutureBuilder<WindowsDeviceInfo>(
      future: deviceInfoPlugin.windowsInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          WindowsDeviceInfo info = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                item('Computer Name', info.computerName),
                item('Number of Cores', info.numberOfCores.toString()),
                item('System Memory in Megabytes', info.systemMemoryInMegabytes.toString()),
                item('User Name', info.userName),
                item('Major Version', info.majorVersion.toString()),
                item('Minor Version', info.minorVersion.toString()),
                item('Build Number', info.buildNumber.toString()),
                item('Platform ID', info.platformId.toString()),
                item('Display Version', info.displayVersion),
                item('Product Type', info.productType.toString()),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
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
          IosDeviceInfo info = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                item('Device Model', info.model),
                item('Device Name', info.name),
                item('System Name', info.systemName),
                item('System Version', info.systemVersion),
                item('Device Is Physical', info.isPhysicalDevice.toString()),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget item(String name, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}