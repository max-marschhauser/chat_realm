import 'package:realm/realm.dart';

part 'schemas.realm.dart';

@RealmModel()
class _Item {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String message;
  @MapTo('owner_id')
  late String ownerId;
}


/// nakon promjene u fileu treba okinuti
/// dart run realm generate
/// da bi se schemas.realm.dart ponovno izgenerirao