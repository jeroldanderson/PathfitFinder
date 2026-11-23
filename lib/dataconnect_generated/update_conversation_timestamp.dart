part of 'generated.dart';

class UpdateConversationTimestampVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  UpdateConversationTimestampVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateConversationTimestampData> dataDeserializer = (dynamic json)  => UpdateConversationTimestampData.fromJson(jsonDecode(json));
  Serializer<UpdateConversationTimestampVariables> varsSerializer = (UpdateConversationTimestampVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateConversationTimestampData, UpdateConversationTimestampVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateConversationTimestampData, UpdateConversationTimestampVariables> ref() {
    UpdateConversationTimestampVariables vars= UpdateConversationTimestampVariables(id: id,);
    return _dataConnect.mutation("UpdateConversationTimestamp", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateConversationTimestampConversationUpdate {
  final String id;
  UpdateConversationTimestampConversationUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateConversationTimestampConversationUpdate otherTyped = other as UpdateConversationTimestampConversationUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateConversationTimestampConversationUpdate({
    required this.id,
  });
}

@immutable
class UpdateConversationTimestampData {
  final UpdateConversationTimestampConversationUpdate? conversation_update;
  UpdateConversationTimestampData.fromJson(dynamic json):
  
  conversation_update = json['conversation_update'] == null ? null : UpdateConversationTimestampConversationUpdate.fromJson(json['conversation_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateConversationTimestampData otherTyped = other as UpdateConversationTimestampData;
    return conversation_update == otherTyped.conversation_update;
    
  }
  @override
  int get hashCode => conversation_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (conversation_update != null) {
      json['conversation_update'] = conversation_update!.toJson();
    }
    return json;
  }

  UpdateConversationTimestampData({
    this.conversation_update,
  });
}

@immutable
class UpdateConversationTimestampVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateConversationTimestampVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateConversationTimestampVariables otherTyped = other as UpdateConversationTimestampVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateConversationTimestampVariables({
    required this.id,
  });
}

