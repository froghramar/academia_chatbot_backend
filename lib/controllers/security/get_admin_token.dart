import 'package:aqueduct/aqueduct.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:password/password.dart';

import '../../application_configuration.dart';
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

			final requestHeaders = request.raw.headers;
			final config = ApplicationConfiguration.getInstance();

			final payload = {
				'UserName': admin['UserName'],
				'Name': admin['Name'],
				'Email': admin['Email'],
				'Roles': [
					'admin'
				],
				'_id': admin['_id'],
			};

			final claimSet = JwtClaim(
				subject: admin['Email'].toString(),
				issuer: config.jwt['issuer'],
				audience: <String>[
					requestHeaders.value('user-agent')
				],
				payload: payload,
			);

			final token = issueJwtHS256(claimSet, config.jwt['secret']);
			return Response.ok({
				'Token': token,
				'TokenData': payload,
			});
		} else {
			return Response.unauthorized();
		}
	} else {
		return Response.notFound();
	}
}
