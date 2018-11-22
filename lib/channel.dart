import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'controllers/admin/admin_controller.dart';

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
