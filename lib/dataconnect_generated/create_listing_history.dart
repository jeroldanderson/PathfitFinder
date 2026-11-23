part of 'generated.dart';

class CreateListingHistoryVariablesBuilder {
  String listingId;
  String changedById;
  String fieldName;
  Optional<String> _oldValue = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _newValue = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateListingHistoryVariablesBuilder oldValue(String? t) {
   _oldValue.value = t;
   return this;
  }
  CreateListingHistoryVariablesBuilder newValue(String? t) {
   _newValue.value = t;
   return this;
  }

  CreateListingHistoryVariablesBuilder(this._dataConnect, {required  this.listingId,required  this.changedById,required  this.fieldName,});
  Deserializer<CreateListingHistoryData> dataDeserializer = (dynamic json)  => CreateListingHistoryData.fromJson(jsonDecode(json));
  Serializer<CreateListingHistoryVariables> varsSerializer = (CreateListingHistoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateListingHistoryData, CreateListingHistoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateListingHistoryData, CreateListingHistoryVariables> ref() {
    CreateListingHistoryVariables vars= CreateListingHistoryVariables(listingId: listingId,changedById: changedById,fieldName: fieldName,oldValue: _oldValue,newValue: _newValue,);
    return _dataConnect.mutation("CreateListingHistory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateListingHistoryListingHistoryInsert {
  final String id;
  CreateListingHistoryListingHistoryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingHistoryListingHistoryInsert otherTyped = other as CreateListingHistoryListingHistoryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateListingHistoryListingHistoryInsert({
    required this.id,
  });
}

@immutable
class CreateListingHistoryData {
  final CreateListingHistoryListingHistoryInsert listingHistory_insert;
  CreateListingHistoryData.fromJson(dynamic json):
  
  listingHistory_insert = CreateListingHistoryListingHistoryInsert.fromJson(json['listingHistory_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingHistoryData otherTyped = other as CreateListingHistoryData;
    return listingHistory_insert == otherTyped.listingHistory_insert;
    
  }
  @override
  int get hashCode => listingHistory_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listingHistory_insert'] = listingHistory_insert.toJson();
    return json;
  }

  CreateListingHistoryData({
    required this.listingHistory_insert,
  });
}

@immutable
class CreateListingHistoryVariables {
  final String listingId;
  final String changedById;
  final String fieldName;
  late final Optional<String>oldValue;
  late final Optional<String>newValue;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateListingHistoryVariables.fromJson(Map<String, dynamic> json):
  
  listingId = nativeFromJson<String>(json['listingId']),
  changedById = nativeFromJson<String>(json['changedById']),
  fieldName = nativeFromJson<String>(json['fieldName']) {
  
  
  
  
  
    oldValue = Optional.optional(nativeFromJson, nativeToJson);
    oldValue.value = json['oldValue'] == null ? null : nativeFromJson<String>(json['oldValue']);
  
  
    newValue = Optional.optional(nativeFromJson, nativeToJson);
    newValue.value = json['newValue'] == null ? null : nativeFromJson<String>(json['newValue']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingHistoryVariables otherTyped = other as CreateListingHistoryVariables;
    return listingId == otherTyped.listingId && 
    changedById == otherTyped.changedById && 
    fieldName == otherTyped.fieldName && 
    oldValue == otherTyped.oldValue && 
    newValue == otherTyped.newValue;
    
  }
  @override
  int get hashCode => Object.hashAll([listingId.hashCode, changedById.hashCode, fieldName.hashCode, oldValue.hashCode, newValue.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listingId'] = nativeToJson<String>(listingId);
    json['changedById'] = nativeToJson<String>(changedById);
    json['fieldName'] = nativeToJson<String>(fieldName);
    if(oldValue.state == OptionalState.set) {
      json['oldValue'] = oldValue.toJson();
    }
    if(newValue.state == OptionalState.set) {
      json['newValue'] = newValue.toJson();
    }
    return json;
  }

  CreateListingHistoryVariables({
    required this.listingId,
    required this.changedById,
    required this.fieldName,
    required this.oldValue,
    required this.newValue,
  });
}

