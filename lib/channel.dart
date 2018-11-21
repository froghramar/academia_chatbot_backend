import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class AcademiaChatBotBackendChannel extends ApplicationChannel {

	@override
	Future prepare() async {
		logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
	}

	@override
	Controller get entryPoint {
		final router = Router();

		router
			.route("/admin/*")
			.link(() => AdminController());

		return router;
	}
}

class AdminController extends Controller {

	@override
	Future<RequestOrResponse> handle(Request request) async {
		if (request.method != 'POST') {
			return Response.notFound();
		}
		switch (request.path.remainingPath) {
			case 'list':
				return await getAdminList(request);
				break;
			default:
				return Response.notFound();
				break;
		}
	}

	Future<Response> getAdminList(Request request) async {
		return Response.ok([
			{'id': 11, 'name': 'Mr. Nice'},
			{'id': 12, 'name': 'Narco'},
			{'id': 13, 'name': 'Bombasto'},
			{'id': 14, 'name': 'Celeritas'},
			{'id': 15, 'name': 'Magneta'},
		]);
	}

}
