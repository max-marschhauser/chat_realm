// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Item extends _Item with RealmEntity, RealmObjectBase, RealmObject {
  Item(
    ObjectId id,
    String message,
    String ownerId,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  Item._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get message => RealmObjectBase.get<String>(this, 'message') as String;
  @override
  set message(String value) => RealmObjectBase.set(this, 'message', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<Item>> get changes =>
      RealmObjectBase.getChanges<Item>(this);

  @override
  Item freeze() => RealmObjectBase.freezeObject<Item>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'message': message.toEJson(),
      'owner_id': ownerId.toEJson(),
    };
  }

  static EJsonValue _toEJson(Item value) => value.toEJson();
  static Item _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'message': EJsonValue message,
        'owner_id': EJsonValue ownerId,
      } =>
        Item(
          fromEJson(id),
          fromEJson(message),
          fromEJson(ownerId),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Item._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Item, 'Item', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('message', RealmPropertyType.string),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
