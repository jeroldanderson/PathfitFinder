part of 'generated.dart';

class CreateVerificationSubmissionVariablesBuilder {
  String userId;
  VerificationDocType documentType;
  String documentUrl;

  final FirebaseDataConnect _dataConnect;
  CreateVerificationSubmissionVariablesBuilder(this._dataConnect, {required  this.userId,required  this.documentType,required  this.documentUrl,});
  Deserializer<CreateVerificationSubmissionData> dataDeserializer = (dynamic json)  => CreateVerificationSubmissionData.fromJson(jsonDecode(json));
  Serializer<CreateVerificationSubmissionVariables> varsSerializer = (CreateVerificationSubmissionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateVerificationSubmissionData, CreateVerificationSubmissionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateVerificationSubmissionData, CreateVerificationSubmissionVariables> ref() {
    CreateVerificationSubmissionVariables vars= CreateVerificationSubmissionVariables(userId: userId,documentType: documentType,documentUrl: documentUrl,);
    return _dataConnect.mutation("CreateVerificationSubmission", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateVerificationSubmissionVerificationSubmissionInsert {
  final String id;
  CreateVerificationSubmissionVerificationSubmissionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateVerificationSubmissionVerificationSubmissionInsert otherTyped = other as CreateVerificationSubmissionVerificationSubmissionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateVerificationSubmissionVerificationSubmissionInsert({
    required this.id,
  });
}

@immutable
class CreateVerificationSubmissionData {
  final CreateVerificationSubmissionVerificationSubmissionInsert verificationSubmission_insert;
  CreateVerificationSubmissionData.fromJson(dynamic json):
  
  verificationSubmission_insert = CreateVerificationSubmissionVerificationSubmissionInsert.fromJson(json['verificationSubmission_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateVerificationSubmissionData otherTyped = other as CreateVerificationSubmissionData;
    return verificationSubmission_insert == otherTyped.verificationSubmission_insert;
    
  }
  @override
  int get hashCode => verificationSubmission_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['verificationSubmission_insert'] = verificationSubmission_insert.toJson();
    return json;
  }

  CreateVerificationSubmissionData({
    required this.verificationSubmission_insert,
  });
}

@immutable
class CreateVerificationSubmissionVariables {
  final String userId;
  final VerificationDocType documentType;
  final String documentUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateVerificationSubmissionVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  documentType = VerificationDocType.values.byName(json['documentType']),
  documentUrl = nativeFromJson<String>(json['documentUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateVerificationSubmissionVariables otherTyped = other as CreateVerificationSubmissionVariables;
    return userId == otherTyped.userId && 
    documentType == otherTyped.documentType && 
    documentUrl == otherTyped.documentUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, documentType.hashCode, documentUrl.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['documentType'] = 
    documentType.name
    ;
    json['documentUrl'] = nativeToJson<String>(documentUrl);
    return json;
  }

  CreateVerificationSubmissionVariables({
    required this.userId,
    required this.documentType,
    required this.documentUrl,
  });
}

