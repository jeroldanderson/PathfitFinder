part of 'generated.dart';

class UpdateUserProfileVariablesBuilder {
  String id;
  String fullName;
  Optional<String> _collegeOrFaculty = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateUserProfileVariablesBuilder collegeOrFaculty(String? t) {
   _collegeOrFaculty.value = t;
   return this;
  }

  UpdateUserProfileVariablesBuilder(this._dataConnect, {required  this.id,required  this.fullName,});
  Deserializer<UpdateUserProfileData> dataDeserializer = (dynamic json)  => UpdateUserProfileData.fromJson(jsonDecode(json));
  Serializer<UpdateUserProfileVariables> varsSerializer = (UpdateUserProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateUserProfileData, UpdateUserProfileVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserProfileData, UpdateUserProfileVariables> ref() {
    UpdateUserProfileVariables vars= UpdateUserProfileVariables(id: id,fullName: fullName,collegeOrFaculty: _collegeOrFaculty,);
    return _dataConnect.mutation("UpdateUserProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateUserProfileUserUpdate {
  final String id;
  UpdateUserProfileUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserProfileUserUpdate otherTyped = other as UpdateUserProfileUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserProfileUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserProfileData {
  final UpdateUserProfileUserUpdate? user_update;
  UpdateUserProfileData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserProfileUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserProfileData otherTyped = other as UpdateUserProfileData;
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

  UpdateUserProfileData({
    this.user_update,
  });
}

@immutable
class UpdateUserProfileVariables {
  final String id;
  final String fullName;
  late final Optional<String>collegeOrFaculty;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateUserProfileVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  fullName = nativeFromJson<String>(json['fullName']) {
  
  
  
  
    collegeOrFaculty = Optional.optional(nativeFromJson, nativeToJson);
    collegeOrFaculty.value = json['collegeOrFaculty'] == null ? null : nativeFromJson<String>(json['collegeOrFaculty']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserProfileVariables otherTyped = other as UpdateUserProfileVariables;
    return id == otherTyped.id && 
    fullName == otherTyped.fullName && 
    collegeOrFaculty == otherTyped.collegeOrFaculty;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, fullName.hashCode, collegeOrFaculty.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['fullName'] = nativeToJson<String>(fullName);
    if(collegeOrFaculty.state == OptionalState.set) {
      json['collegeOrFaculty'] = collegeOrFaculty.toJson();
    }
    return json;
  }

  UpdateUserProfileVariables({
    required this.id,
    required this.fullName,
    required this.collegeOrFaculty,
  });
}

