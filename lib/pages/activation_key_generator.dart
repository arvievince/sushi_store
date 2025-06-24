import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sushi_store/pages/helper/encryption_helpder.dart';
// import '../helpers/encryption_helper.dart'; // Adjust the path as needed

class ActivationKeyGeneratorPage extends StatefulWidget {
  const ActivationKeyGeneratorPage({Key? key}) : super(key: key);

  @override
  State<ActivationKeyGeneratorPage> createState() =>
      _ActivationKeyGeneratorPageState();
}

class _ActivationKeyGeneratorPageState
    extends State<ActivationKeyGeneratorPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  void _generateEncryptedString() {
    final input = _inputController.text;
    if (input.isEmpty) {
      _outputController.text = '';
      return;
    }

    // SHA256 hash of the encrypted base64 string
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);

    // Use EncryptionHelper for AES encryption
    final encryptedBase64 = EncryptHelper.encryptText(digest.toString());

    final hashed = encryptedBase64.toString();

    setState(() {
      _outputController.text = hashed;
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activation Key Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter text to encrypt',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _generateEncryptedString(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _outputController,
              decoration: const InputDecoration(
                labelText: 'Encrypted string',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
