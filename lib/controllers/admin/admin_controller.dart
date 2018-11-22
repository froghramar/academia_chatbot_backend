import 'package:aqueduct/aqueduct.dart';
import 'get-admin-list.dart';
import 'get-admin.dart';

class AdminController extends Controller {

	@override
	Future<RequestOrResponse> handle(Request request) async {
		if (request.method != 'POST') {
			return Response.notFound();
		}
		switch (request.path.remainingPath) {
			case 'get-list':
				return await getAdminList(request);
				break;
			case 'get-one':
				return getAdmin(request);
				break;
			default:
				return Response.notFound();
				break;
		}
	}

}
