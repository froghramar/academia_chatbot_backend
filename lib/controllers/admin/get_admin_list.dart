import 'package:aqueduct/aqueduct.dart';
import '../../database.dart';

Future<Response> getAdminList(Request request) async {

	final Map requestBody = await request.body.decode<Map>();

	final collection = await Database.collection('Admins');
	final admins = await collection.find(requestBody['filter']).toList();

	return Response.ok(admins);
}
