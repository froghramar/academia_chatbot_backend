import 'package:aqueduct/aqueduct.dart';

import '../../application_configuration.dart';
import 'create_seed_data.dart';
import 'get_admin.dart';
import 'get_admin_list.dart';

class AdminController extends Controller {

	@override
	Future<RequestOrResponse> handle(Request request) async {

		final config = ApplicationConfiguration.getInstance();

		if (request.method != 'POST') {
			return Response.notFound();
		}
		switch (request.path.remainingPath) {
			case 'get-list':
				return await getAdminList(request);
				break;
			case 'create-seed-data':
				if (config.production) {
					return Response.notFound();
				} else {
					return await createSeedData(request);
				}
				break;
			case 'get-one':
				return await getAdmin(request);
				break;
			default:
				return Response.notFound();
				break;
		}
	}

}
