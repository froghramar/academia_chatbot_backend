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
			.route("/example")
			.linkFunction((request) async {
				return Response.ok({"key": "value"});
			});

		return router;
	}
}
