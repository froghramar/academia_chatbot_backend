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
		return Response.ok({"path": request.path.remainingPath});
	}

}
