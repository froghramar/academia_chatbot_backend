import 'package:aqueduct/aqueduct.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:password_hash/password_hash.dart';

import '../../application_configuration.dart';
import '../../database.dart';

Future<Response> createSeedData(Request request) async {

	final adminCollection = await Database.collection('Admins');
	final config = ApplicationConfiguration.getInstance();

	final generator = PBKDF2();
	final salt = Salt.generateAsBase64String(config.passwordHash['saltLength']);
	final hash = generator.generateKey(config.defaultAdminPassword, salt, config.passwordHash['rounds'], config.passwordHash['keyLength']);
	
	await adminCollection.insert({
		'_id': ObjectId().toHexString(),
		'Name': 'Test Admin',
		'Email': 'testadmin@chatbot.com',
		'UserName': 'testadmin',
		'Password': hash
	});

	return Response.ok('Seed Data Added');
}
