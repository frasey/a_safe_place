import 'dart:developer';
import 'package:a_safe_place/Database/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db); // this will print out settings that we need
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);
    // print(await collection.find().toList());     checks successfully connected with no errors
  }
}
