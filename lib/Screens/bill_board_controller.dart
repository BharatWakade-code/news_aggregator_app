import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  late IO.Socket socket;
  final textController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    socket = IO.io(
      'http://10.0.2.2:3000', // Change this to your server IP
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.onConnect((_) => print('✅ Connected to server'));
    socket.onDisconnect((_) => print('❌ Disconnected'));
  }

  void sendText() {
    socket.emit('send_text', {'text': textController.text});
  }

  void sendImage() {
    socket.emit('send_image', {'url': imageController.text});
  }

  void clearDisplay() {
    socket.emit('clear');
  }

  @override
  void dispose() {
    textController.dispose();
    imageController.dispose();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billboard Controller')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Enter Text'),
            ),
            ElevatedButton(onPressed: sendText, child: const Text('Send Text')),
            const SizedBox(height: 20),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            ElevatedButton(onPressed: sendImage, child: const Text('Send Image')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: clearDisplay,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Clear Display'),
            ),
          ],
        ),
      ),
    );
  }
}
