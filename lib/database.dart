import 'package:mongo_dart/mongo_dart.dart';
import 'application_configuration.dart';

class Database {

	static Future<DbCollection> collection(String collectionName) {

		final config = ApplicationConfiguration('config.yaml');

		final Db database = Db(config.database["connectionString"]);
		return database.open().then((d) {
				return database.collection(collectionName);
			}
		);
	}
}
