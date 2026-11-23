part of 'generated.dart';

class ReviewVerificationSubmissionVariablesBuilder {
  String userId;
  String submissionId;
  VerificationStatus status;

  final FirebaseDataConnect _dataConnect;
  ReviewVerificationSubmissionVariablesBuilder(this._dataConnect, {required  this.userId,required  this.submissionId,required  this.status,});
  Deserializer<ReviewVerificationSubmissionData> dataDeserializer = (dynamic json)  => ReviewVerificationSubmissionData.fromJson(jsonDecode(json));
  Serializer<ReviewVerificationSubmissionVariables> varsSerializer = (ReviewVerificationSubmissionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ReviewVerificationSubmissionData, ReviewVerificationSubmissionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ReviewVerificationSubmissionData, ReviewVerificationSubmissionVariables> ref() {
    ReviewVerificationSubmissionVariables vars= ReviewVerificationSubmissionVariables(userId: userId,submissionId: submissionId,status: status,);
    return _dataConnect.mutation("ReviewVerificationSubmission", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ReviewVerificationSubmissionUserUpdate {
  final String id;
  ReviewVerificationSubmissionUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReviewVerificationSubmissionUserUpdate otherTyped = other as ReviewVerificationSubmissionUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ReviewVerificationSubmissionUserUpdate({
    required this.id,
  });
}

@immutable
class ReviewVerificationSubmissionVerificationSubmissionUpdate {
  final String id;
  ReviewVerificationSubmissionVerificationSubmissionUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReviewVerificationSubmissionVerificationSubmissionUpdate otherTyped = other as ReviewVerificationSubmissionVerificationSubmissionUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ReviewVerificationSubmissionVerificationSubmissionUpdate({
    required this.id,
  });
}

@immutable
class ReviewVerificationSubmissionData {
  final ReviewVerificationSubmissionUserUpdate? user_update;
  final ReviewVerificationSubmissionVerificationSubmissionUpdate? verificationSubmission_update;
  ReviewVerificationSubmissionData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : ReviewVerificationSubmissionUserUpdate.fromJson(json['user_update']),
  verificationSubmission_update = json['verificationSubmission_update'] == null ? null : ReviewVerificationSubmissionVerificationSubmissionUpdate.fromJson(json['verificationSubmission_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReviewVerificationSubmissionData otherTyped = other as ReviewVerificationSubmissionData;
    return user_update == otherTyped.user_update && 
    verificationSubmission_update == otherTyped.verificationSubmission_update;
    
  }
  @override
  int get hashCode => Object.hashAll([user_update.hashCode, verificationSubmission_update.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    if (verificationSubmission_update != null) {
      json['verificationSubmission_update'] = verificationSubmission_update!.toJson();
    }
    return json;
  }

  ReviewVerificationSubmissionData({
    this.user_update,
    this.verificationSubmission_update,
  });
}

@immutable
class ReviewVerificationSubmissionVariables {
  final String userId;
  final String submissionId;
  final VerificationStatus status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ReviewVerificationSubmissionVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  submissionId = nativeFromJson<String>(json['submissionId']),
  status = VerificationStatus.values.byName(json['status']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReviewVerificationSubmissionVariables otherTyped = other as ReviewVerificationSubmissionVariables;
    return userId == otherTyped.userId && 
    submissionId == otherTyped.submissionId && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, submissionId.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['submissionId'] = nativeToJson<String>(submissionId);
    json['status'] = 
    status.name
    ;
    return json;
  }

  ReviewVerificationSubmissionVariables({
    required this.userId,
    required this.submissionId,
    required this.status,
  });
}

