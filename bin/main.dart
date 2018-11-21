import 'dart:async';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:academia_chatbot_backend/channel.dart';

Future main() async {
    final app = Application<AcademiaChatBotBackendChannel>()
        ..options.configurationFilePath = "config.yaml"
        ..options.port = 8888;

    final count = Platform.numberOfProcessors ~/ 2;
    await app.start(numberOfInstances: count > 0 ? count : 1);

    print("Application started on port: ${app.options.port}.");
    print("Use Ctrl-C (SIGINT) to stop running the application.");
}
