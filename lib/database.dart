import 'package:mongo_dart/mongo_dart.dart';

class Database {

	static Future<DbCollection> collection(String collectionName) {
		final Db database = Db('mongodb://localhost:27017/schooldb');
		return database.open().then((d) {
				return database.collection(collectionName);
			}
		);
	}
}
