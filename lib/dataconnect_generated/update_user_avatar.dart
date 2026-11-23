part of 'generated.dart';

class UpdateUserAvatarVariablesBuilder {
  String id;
  String avatarUrl;

  final FirebaseDataConnect _dataConnect;
  UpdateUserAvatarVariablesBuilder(this._dataConnect, {required  this.id,required  this.avatarUrl,});
  Deserializer<UpdateUserAvatarData> dataDeserializer = (dynamic json)  => UpdateUserAvatarData.fromJson(jsonDecode(json));
  Serializer<UpdateUserAvatarVariables> varsSerializer = (UpdateUserAvatarVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateUserAvatarData, UpdateUserAvatarVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserAvatarData, UpdateUserAvatarVariables> ref() {
    UpdateUserAvatarVariables vars= UpdateUserAvatarVariables(id: id,avatarUrl: avatarUrl,);
    return _dataConnect.mutation("UpdateUserAvatar", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateUserAvatarUserUpdate {
  final String id;
  UpdateUserAvatarUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserAvatarUserUpdate otherTyped = other as UpdateUserAvatarUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserAvatarUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserAvatarData {
  final UpdateUserAvatarUserUpdate? user_update;
  UpdateUserAvatarData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserAvatarUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserAvatarData otherTyped = other as UpdateUserAvatarData;
    return user_update == otherTyped.user_update;
    
  }
  @override
  int get hashCode => user_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    return json;
  }

  UpdateUserAvatarData({
    this.user_update,
  });
}

@immutable
class UpdateUserAvatarVariables {
  final String id;
  final String avatarUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateUserAvatarVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  avatarUrl = nativeFromJson<String>(json['avatarUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserAvatarVariables otherTyped = other as UpdateUserAvatarVariables;
    return id == otherTyped.id && 
    avatarUrl == otherTyped.avatarUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, avatarUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['avatarUrl'] = nativeToJson<String>(avatarUrl);
    return json;
  }

  UpdateUserAvatarVariables({
    required this.id,
    required this.avatarUrl,
  });
}

