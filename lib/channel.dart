import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:mongo_dart/mongo_dart.dart';

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

		final Db database = Db('mongodb://localhost:27017/schooldb');
		await database.open();

		final collection = database.collection('Admins');
		final admins = await collection.find().toList();

		return Response.ok(admins);
	}

}
