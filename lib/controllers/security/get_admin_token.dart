import 'package:aqueduct/aqueduct.dart';
import 'package:password/password.dart';

import '../../database.dart';

Future<Response> getAdminToken(Request request) async {

	final Map<String,dynamic> requestBody = await request.body.decode<Map<String,dynamic>>();

	if ((requestBody.length < 2) || !requestBody.containsKey('Password')) {
		return Response.notFound();
	}

	final adminFilter = Map<String,dynamic>.from(requestBody);

	final password = adminFilter['Password'].toString();
	adminFilter.remove('Password');

	final collection = await Database.collection('Admins');
	final admin = await collection.findOne(adminFilter);

	if (admin != null) {
		if (Password.verify(password, admin['Password'].toString())) {
			return Response.ok(admin);
		} else {
			return Response.unauthorized();
		}
	} else {
		return Response.notFound();
	}
}
