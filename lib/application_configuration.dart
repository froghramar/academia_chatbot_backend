import 'dart:io';
import 'package:safe_config/safe_config.dart';

class ApplicationConfiguration extends Configuration {

	ApplicationConfiguration(String fileName) :
			super.fromFile(File(fileName));

	static ApplicationConfiguration _applicationConfiguration;

	static ApplicationConfiguration getInstance() => _applicationConfiguration ??= ApplicationConfiguration('config.yaml');

	Map<String, String> database;
}
