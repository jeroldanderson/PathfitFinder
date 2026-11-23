part of 'generated.dart';

class CreateUserVariablesBuilder {
  String email;
  String fullName;
  Optional<String> _collegeOrFaculty = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _batchYear = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateUserVariablesBuilder collegeOrFaculty(String? t) {
   _collegeOrFaculty.value = t;
   return this;
  }
  CreateUserVariablesBuilder batchYear(int? t) {
   _batchYear.value = t;
   return this;
  }

  CreateUserVariablesBuilder(this._dataConnect, {required  this.email,required  this.fullName,});
  Deserializer<CreateUserData> dataDeserializer = (dynamic json)  => CreateUserData.fromJson(jsonDecode(json));
  Serializer<CreateUserVariables> varsSerializer = (CreateUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateUserData, CreateUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateUserData, CreateUserVariables> ref() {
    CreateUserVariables vars= CreateUserVariables(email: email,fullName: fullName,collegeOrFaculty: _collegeOrFaculty,batchYear: _batchYear,);
    return _dataConnect.mutation("CreateUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateUserUserInsert {
  final String id;
  CreateUserUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserUserInsert otherTyped = other as CreateUserUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateUserUserInsert({
    required this.id,
  });
}

@immutable
class CreateUserData {
  final CreateUserUserInsert user_insert;
  CreateUserData.fromJson(dynamic json):
  
  user_insert = CreateUserUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserData otherTyped = other as CreateUserData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  CreateUserData({
    required this.user_insert,
  });
}

@immutable
class CreateUserVariables {
  final String email;
  final String fullName;
  late final Optional<String>collegeOrFaculty;
  late final Optional<int>batchYear;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateUserVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']),
  fullName = nativeFromJson<String>(json['fullName']) {
  
  
  
  
    collegeOrFaculty = Optional.optional(nativeFromJson, nativeToJson);
    collegeOrFaculty.value = json['collegeOrFaculty'] == null ? null : nativeFromJson<String>(json['collegeOrFaculty']);
  
  
    batchYear = Optional.optional(nativeFromJson, nativeToJson);
    batchYear.value = json['batchYear'] == null ? null : nativeFromJson<int>(json['batchYear']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserVariables otherTyped = other as CreateUserVariables;
    return email == otherTyped.email && 
    fullName == otherTyped.fullName && 
    collegeOrFaculty == otherTyped.collegeOrFaculty && 
    batchYear == otherTyped.batchYear;
    
  }
  @override
  int get hashCode => Object.hashAll([email.hashCode, fullName.hashCode, collegeOrFaculty.hashCode, batchYear.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    json['fullName'] = nativeToJson<String>(fullName);
    if(collegeOrFaculty.state == OptionalState.set) {
      json['collegeOrFaculty'] = collegeOrFaculty.toJson();
    }
    if(batchYear.state == OptionalState.set) {
      json['batchYear'] = batchYear.toJson();
    }
    return json;
  }

  CreateUserVariables({
    required this.email,
    required this.fullName,
    required this.collegeOrFaculty,
    required this.batchYear,
  });
}

