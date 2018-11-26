import 'package:aqueduct/aqueduct.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:password/password.dart';

import '../../application_configuration.dart';
import '../../database.dart';

Future<Response> createSeedData(Request request) async {

	final adminCollection = await Database.collection('Admins');
	final config = ApplicationConfiguration.getInstance();
	final hashedPassword = Password.hash(config.defaultAdminPassword, PBKDF2());

	await adminCollection.insert({
		'_id': ObjectId().toHexString(),
		'Name': 'Test Admin',
		'Email': 'testadmin@chatbot.com',
		'UserName': 'testadmin',
		'Password': hashedPassword
	});

	return Response.ok('Seed Data Added');
}
