import 'package:aqueduct/aqueduct.dart';
import '../../database.dart';

Future<Response> getAdmin(Request request) async {

	final Map requestBody = await request.body.decode<Map>();

	final collection = await Database.collection('Admins');
	final admin = await collection.findOne(requestBody['filter']);

	return Response.ok(admin);
}
