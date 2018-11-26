import 'package:aqueduct/aqueduct.dart';
import 'get_admin_token.dart';

class SecurityController extends Controller {

	@override
	Future<RequestOrResponse> handle(Request request) async {

		if (request.method != 'POST') {
			return Response.notFound();
		}
		switch (request.path.remainingPath) {
			case 'get-admin-token':
				return await getAdminToken(request);
				break;
			default:
				return Response.notFound();
				break;
		}
	}

}
