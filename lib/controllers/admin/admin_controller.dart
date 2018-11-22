import 'package:aqueduct/aqueduct.dart';
import '../../database.dart';

class AdminController extends Controller {

	@override
	Future<RequestOrResponse> handle(Request request) async {
		if (request.method != 'POST') {
			return Response.notFound();
		}
		switch (request.path.remainingPath) {
			case 'list':
				return await _getAdminList(request);
				break;
			default:
				return Response.notFound();
				break;
		}
	}

	Future<Response> _getAdminList(Request request) async {

		final collection = await Database.collection('Admins');
		final admins = await collection.find().toList();

		return Response.ok(admins);
	}

}
