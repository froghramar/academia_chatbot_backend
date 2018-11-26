import 'dart:io';
import 'package:safe_config/safe_config.dart';

class ApplicationConfiguration extends Configuration {

	ApplicationConfiguration(String fileName) :
			super.fromFile(File(fileName));

	static final ApplicationConfiguration _applicationConfiguration = ApplicationConfiguration('config.yaml');

	static ApplicationConfiguration getInstance() => _applicationConfiguration;

	bool production;
	Map<String, String> database;
	String defaultAdminPassword;
}
