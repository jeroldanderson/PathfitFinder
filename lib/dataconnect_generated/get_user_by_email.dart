part of 'generated.dart';

class GetUserByEmailVariablesBuilder {
  String email;

  final FirebaseDataConnect _dataConnect;
  GetUserByEmailVariablesBuilder(this._dataConnect, {required  this.email,});
  Deserializer<GetUserByEmailData> dataDeserializer = (dynamic json)  => GetUserByEmailData.fromJson(jsonDecode(json));
  Serializer<GetUserByEmailVariables> varsSerializer = (GetUserByEmailVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByEmailData, GetUserByEmailVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetUserByEmailData, GetUserByEmailVariables> ref() {
    GetUserByEmailVariables vars= GetUserByEmailVariables(email: email,);
    return _dataConnect.query("GetUserByEmail", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByEmailUsers {
  final String id;
  final String email;
  final String fullName;
  final EnumValue<UserRole> role;
  final String? collegeOrFaculty;
  final int? batchYear;
  final EnumValue<VerificationStatus> verificationStatus;
  final String? avatarUrl;
  GetUserByEmailUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  email = nativeFromJson<String>(json['email']),
  fullName = nativeFromJson<String>(json['fullName']),
  role = userRoleDeserializer(json['role']),
  collegeOrFaculty = json['collegeOrFaculty'] == null ? null : nativeFromJson<String>(json['collegeOrFaculty']),
  batchYear = json['batchYear'] == null ? null : nativeFromJson<int>(json['batchYear']),
  verificationStatus = verificationStatusDeserializer(json['verificationStatus']),
  avatarUrl = json['avatarUrl'] == null ? null : nativeFromJson<String>(json['avatarUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailUsers otherTyped = other as GetUserByEmailUsers;
    return id == otherTyped.id && 
    email == otherTyped.email && 
    fullName == otherTyped.fullName && 
    role == otherTyped.role && 
    collegeOrFaculty == otherTyped.collegeOrFaculty && 
    batchYear == otherTyped.batchYear && 
    verificationStatus == otherTyped.verificationStatus && 
    avatarUrl == otherTyped.avatarUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, email.hashCode, fullName.hashCode, role.hashCode, collegeOrFaculty.hashCode, batchYear.hashCode, verificationStatus.hashCode, avatarUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['email'] = nativeToJson<String>(email);
    json['fullName'] = nativeToJson<String>(fullName);
    json['role'] = 
    userRoleSerializer(role)
    ;
    if (collegeOrFaculty != null) {
      json['collegeOrFaculty'] = nativeToJson<String?>(collegeOrFaculty);
    }
    if (batchYear != null) {
      json['batchYear'] = nativeToJson<int?>(batchYear);
    }
    json['verificationStatus'] = 
    verificationStatusSerializer(verificationStatus)
    ;
    if (avatarUrl != null) {
      json['avatarUrl'] = nativeToJson<String?>(avatarUrl);
    }
    return json;
  }

  GetUserByEmailUsers({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.collegeOrFaculty,
    this.batchYear,
    required this.verificationStatus,
    this.avatarUrl,
  });
}

@immutable
class GetUserByEmailData {
  final List<GetUserByEmailUsers> users;
  GetUserByEmailData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetUserByEmailUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailData otherTyped = other as GetUserByEmailData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserByEmailData({
    required this.users,
  });
}

@immutable
class GetUserByEmailVariables {
  final String email;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByEmailVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailVariables otherTyped = other as GetUserByEmailVariables;
    return email == otherTyped.email;
    
  }
  @override
  int get hashCode => email.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  GetUserByEmailVariables({
    required this.email,
  });
}

