import 'package:realm/realm.dart';

part 'person_model.g.dart';

@RealmModel()
class _person {
  @PrimaryKey()
  late ObjectId id;
  late String fullName;
  late String emailAddress;
  
}

final config = Configuration.local([person.schema]);
final realm = Realm(config);
