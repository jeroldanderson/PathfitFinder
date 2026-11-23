part of 'generated.dart';

class GetPendingVerificationsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetPendingVerificationsVariablesBuilder(this._dataConnect, );
  Deserializer<GetPendingVerificationsData> dataDeserializer = (dynamic json)  => GetPendingVerificationsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetPendingVerificationsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetPendingVerificationsData, void> ref() {
    
    return _dataConnect.query("GetPendingVerifications", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetPendingVerificationsVerificationSubmissions {
  final String id;
  final EnumValue<VerificationDocType> documentType;
  final String documentUrl;
  final Timestamp submittedAt;
  final GetPendingVerificationsVerificationSubmissionsUser user;
  GetPendingVerificationsVerificationSubmissions.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  documentType = verificationDocTypeDeserializer(json['documentType']),
  documentUrl = nativeFromJson<String>(json['documentUrl']),
  submittedAt = Timestamp.fromJson(json['submittedAt']),
  user = GetPendingVerificationsVerificationSubmissionsUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPendingVerificationsVerificationSubmissions otherTyped = other as GetPendingVerificationsVerificationSubmissions;
    return id == otherTyped.id && 
    documentType == otherTyped.documentType && 
    documentUrl == otherTyped.documentUrl && 
    submittedAt == otherTyped.submittedAt && 
    user == otherTyped.user;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, documentType.hashCode, documentUrl.hashCode, submittedAt.hashCode, user.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['documentType'] = 
    verificationDocTypeSerializer(documentType)
    ;
    json['documentUrl'] = nativeToJson<String>(documentUrl);
    json['submittedAt'] = submittedAt.toJson();
    json['user'] = user.toJson();
    return json;
  }

  GetPendingVerificationsVerificationSubmissions({
    required this.id,
    required this.documentType,
    required this.documentUrl,
    required this.submittedAt,
    required this.user,
  });
}

@immutable
class GetPendingVerificationsVerificationSubmissionsUser {
  final String id;
  final String email;
  final String fullName;
  final String? collegeOrFaculty;
  final EnumValue<VerificationStatus> verificationStatus;
  GetPendingVerificationsVerificationSubmissionsUser.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  email = nativeFromJson<String>(json['email']),
  fullName = nativeFromJson<String>(json['fullName']),
  collegeOrFaculty = json['collegeOrFaculty'] == null ? null : nativeFromJson<String>(json['collegeOrFaculty']),
  verificationStatus = verificationStatusDeserializer(json['verificationStatus']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPendingVerificationsVerificationSubmissionsUser otherTyped = other as GetPendingVerificationsVerificationSubmissionsUser;
    return id == otherTyped.id && 
    email == otherTyped.email && 
    fullName == otherTyped.fullName && 
    collegeOrFaculty == otherTyped.collegeOrFaculty && 
    verificationStatus == otherTyped.verificationStatus;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, email.hashCode, fullName.hashCode, collegeOrFaculty.hashCode, verificationStatus.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['email'] = nativeToJson<String>(email);
    json['fullName'] = nativeToJson<String>(fullName);
    if (collegeOrFaculty != null) {
      json['collegeOrFaculty'] = nativeToJson<String?>(collegeOrFaculty);
    }
    json['verificationStatus'] = 
    verificationStatusSerializer(verificationStatus)
    ;
    return json;
  }

  GetPendingVerificationsVerificationSubmissionsUser({
    required this.id,
    required this.email,
    required this.fullName,
    this.collegeOrFaculty,
    required this.verificationStatus,
  });
}

@immutable
class GetPendingVerificationsData {
  final List<GetPendingVerificationsVerificationSubmissions> verificationSubmissions;
  GetPendingVerificationsData.fromJson(dynamic json):
  
  verificationSubmissions = (json['verificationSubmissions'] as List<dynamic>)
        .map((e) => GetPendingVerificationsVerificationSubmissions.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPendingVerificationsData otherTyped = other as GetPendingVerificationsData;
    return verificationSubmissions == otherTyped.verificationSubmissions;
    
  }
  @override
  int get hashCode => verificationSubmissions.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['verificationSubmissions'] = verificationSubmissions.map((e) => e.toJson()).toList();
    return json;
  }

  GetPendingVerificationsData({
    required this.verificationSubmissions,
  });
}

