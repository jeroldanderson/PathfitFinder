part of 'generated.dart';

class CreateNotificationVariablesBuilder {
  String userId;
  NotificationType type;
  String title;
  Optional<String> _body = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _referenceId = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateNotificationVariablesBuilder body(String? t) {
   _body.value = t;
   return this;
  }
  CreateNotificationVariablesBuilder referenceId(String? t) {
   _referenceId.value = t;
   return this;
  }

  CreateNotificationVariablesBuilder(this._dataConnect, {required  this.userId,required  this.type,required  this.title,});
  Deserializer<CreateNotificationData> dataDeserializer = (dynamic json)  => CreateNotificationData.fromJson(jsonDecode(json));
  Serializer<CreateNotificationVariables> varsSerializer = (CreateNotificationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNotificationData, CreateNotificationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNotificationData, CreateNotificationVariables> ref() {
    CreateNotificationVariables vars= CreateNotificationVariables(userId: userId,type: type,title: title,body: _body,referenceId: _referenceId,);
    return _dataConnect.mutation("CreateNotification", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateNotificationNotificationInsert {
  final String id;
  CreateNotificationNotificationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateNotificationNotificationInsert otherTyped = other as CreateNotificationNotificationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNotificationNotificationInsert({
    required this.id,
  });
}

@immutable
class CreateNotificationData {
  final CreateNotificationNotificationInsert notification_insert;
  CreateNotificationData.fromJson(dynamic json):
  
  notification_insert = CreateNotificationNotificationInsert.fromJson(json['notification_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateNotificationData otherTyped = other as CreateNotificationData;
    return notification_insert == otherTyped.notification_insert;
    
  }
  @override
  int get hashCode => notification_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['notification_insert'] = notification_insert.toJson();
    return json;
  }

  CreateNotificationData({
    required this.notification_insert,
  });
}

@immutable
class CreateNotificationVariables {
  final String userId;
  final NotificationType type;
  final String title;
  late final Optional<String>body;
  late final Optional<String>referenceId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNotificationVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  type = NotificationType.values.byName(json['type']),
  title = nativeFromJson<String>(json['title']) {
  
  
  
  
  
    body = Optional.optional(nativeFromJson, nativeToJson);
    body.value = json['body'] == null ? null : nativeFromJson<String>(json['body']);
  
  
    referenceId = Optional.optional(nativeFromJson, nativeToJson);
    referenceId.value = json['referenceId'] == null ? null : nativeFromJson<String>(json['referenceId']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateNotificationVariables otherTyped = other as CreateNotificationVariables;
    return userId == otherTyped.userId && 
    type == otherTyped.type && 
    title == otherTyped.title && 
    body == otherTyped.body && 
    referenceId == otherTyped.referenceId;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, type.hashCode, title.hashCode, body.hashCode, referenceId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['type'] = 
    type.name
    ;
    json['title'] = nativeToJson<String>(title);
    if(body.state == OptionalState.set) {
      json['body'] = body.toJson();
    }
    if(referenceId.state == OptionalState.set) {
      json['referenceId'] = referenceId.toJson();
    }
    return json;
  }

  CreateNotificationVariables({
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    required this.referenceId,
  });
}

