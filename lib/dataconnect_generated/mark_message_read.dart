part of 'generated.dart';

class MarkMessageReadVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  MarkMessageReadVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<MarkMessageReadData> dataDeserializer = (dynamic json)  => MarkMessageReadData.fromJson(jsonDecode(json));
  Serializer<MarkMessageReadVariables> varsSerializer = (MarkMessageReadVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<MarkMessageReadData, MarkMessageReadVariables>> execute() {
    return ref().execute();
  }

  MutationRef<MarkMessageReadData, MarkMessageReadVariables> ref() {
    MarkMessageReadVariables vars= MarkMessageReadVariables(id: id,);
    return _dataConnect.mutation("MarkMessageRead", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class MarkMessageReadMessageUpdate {
  final String id;
  MarkMessageReadMessageUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarkMessageReadMessageUpdate otherTyped = other as MarkMessageReadMessageUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MarkMessageReadMessageUpdate({
    required this.id,
  });
}

@immutable
class MarkMessageReadData {
  final MarkMessageReadMessageUpdate? message_update;
  MarkMessageReadData.fromJson(dynamic json):
  
  message_update = json['message_update'] == null ? null : MarkMessageReadMessageUpdate.fromJson(json['message_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarkMessageReadData otherTyped = other as MarkMessageReadData;
    return message_update == otherTyped.message_update;
    
  }
  @override
  int get hashCode => message_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (message_update != null) {
      json['message_update'] = message_update!.toJson();
    }
    return json;
  }

  MarkMessageReadData({
    this.message_update,
  });
}

@immutable
class MarkMessageReadVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  MarkMessageReadVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MarkMessageReadVariables otherTyped = other as MarkMessageReadVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  MarkMessageReadVariables({
    required this.id,
  });
}

