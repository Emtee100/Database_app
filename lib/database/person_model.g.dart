// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class person extends _person with RealmEntity, RealmObjectBase, RealmObject {
  person(
    ObjectId id,
    String fullName,
    String emailAddress,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'fullName', fullName);
    RealmObjectBase.set(this, 'emailAddress', emailAddress);
  }

  person._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get fullName =>
      RealmObjectBase.get<String>(this, 'fullName') as String;
  @override
  set fullName(String value) => RealmObjectBase.set(this, 'fullName', value);

  @override
  String get emailAddress =>
      RealmObjectBase.get<String>(this, 'emailAddress') as String;
  @override
  set emailAddress(String value) =>
      RealmObjectBase.set(this, 'emailAddress', value);

  @override
  Stream<RealmObjectChanges<person>> get changes =>
      RealmObjectBase.getChanges<person>(this);

  @override
  person freeze() => RealmObjectBase.freezeObject<person>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(person._);
    return const SchemaObject(ObjectType.realmObject, person, 'person', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('fullName', RealmPropertyType.string),
      SchemaProperty('emailAddress', RealmPropertyType.string),
    ]);
  }
}
