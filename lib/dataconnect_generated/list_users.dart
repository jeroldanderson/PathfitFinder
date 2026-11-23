part of 'generated.dart';

class ListUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListUsersVariablesBuilder(this._dataConnect, );
  Deserializer<ListUsersData> dataDeserializer = (dynamic json)  => ListUsersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListUsersData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListUsersData, void> ref() {
    
    return _dataConnect.query("ListUsers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListUsersUsers {
  final String id;
  final String email;
  final String fullName;
  final EnumValue<UserRole> role;
  final String? collegeOrFaculty;
  final int? batchYear;
  final EnumValue<VerificationStatus> verificationStatus;
  ListUsersUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  email = nativeFromJson<String>(json['email']),
  fullName = nativeFromJson<String>(json['fullName']),
  role = userRoleDeserializer(json['role']),
  collegeOrFaculty = json['collegeOrFaculty'] == null ? null : nativeFromJson<String>(json['collegeOrFaculty']),
  batchYear = json['batchYear'] == null ? null : nativeFromJson<int>(json['batchYear']),
  verificationStatus = verificationStatusDeserializer(json['verificationStatus']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListUsersUsers otherTyped = other as ListUsersUsers;
    return id == otherTyped.id && 
    email == otherTyped.email && 
    fullName == otherTyped.fullName && 
    role == otherTyped.role && 
    collegeOrFaculty == otherTyped.collegeOrFaculty && 
    batchYear == otherTyped.batchYear && 
    verificationStatus == otherTyped.verificationStatus;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, email.hashCode, fullName.hashCode, role.hashCode, collegeOrFaculty.hashCode, batchYear.hashCode, verificationStatus.hashCode]);
  

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
    return json;
  }

  ListUsersUsers({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.collegeOrFaculty,
    this.batchYear,
    required this.verificationStatus,
  });
}

@immutable
class ListUsersData {
  final List<ListUsersUsers> users;
  ListUsersData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => ListUsersUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListUsersData otherTyped = other as ListUsersData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  ListUsersData({
    required this.users,
  });
}

