part of 'generated.dart';

class GetUserNotificationsVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetUserNotificationsVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetUserNotificationsData> dataDeserializer = (dynamic json)  => GetUserNotificationsData.fromJson(jsonDecode(json));
  Serializer<GetUserNotificationsVariables> varsSerializer = (GetUserNotificationsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserNotificationsData, GetUserNotificationsVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetUserNotificationsData, GetUserNotificationsVariables> ref() {
    GetUserNotificationsVariables vars= GetUserNotificationsVariables(userId: userId,);
    return _dataConnect.query("GetUserNotifications", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserNotificationsNotifications {
  final String id;
  final EnumValue<NotificationType> type;
  final String title;
  final String? body;
  final String? referenceId;
  final bool isRead;
  final Timestamp createdAt;
  GetUserNotificationsNotifications.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  type = notificationTypeDeserializer(json['type']),
  title = nativeFromJson<String>(json['title']),
  body = json['body'] == null ? null : nativeFromJson<String>(json['body']),
  referenceId = json['referenceId'] == null ? null : nativeFromJson<String>(json['referenceId']),
  isRead = nativeFromJson<bool>(json['isRead']),
  createdAt = Timestamp.fromJson(json['createdAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserNotificationsNotifications otherTyped = other as GetUserNotificationsNotifications;
    return id == otherTyped.id && 
    type == otherTyped.type && 
    title == otherTyped.title && 
    body == otherTyped.body && 
    referenceId == otherTyped.referenceId && 
    isRead == otherTyped.isRead && 
    createdAt == otherTyped.createdAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, type.hashCode, title.hashCode, body.hashCode, referenceId.hashCode, isRead.hashCode, createdAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['type'] = 
    notificationTypeSerializer(type)
    ;
    json['title'] = nativeToJson<String>(title);
    if (body != null) {
      json['body'] = nativeToJson<String?>(body);
    }
    if (referenceId != null) {
      json['referenceId'] = nativeToJson<String?>(referenceId);
    }
    json['isRead'] = nativeToJson<bool>(isRead);
    json['createdAt'] = createdAt.toJson();
    return json;
  }

  GetUserNotificationsNotifications({
    required this.id,
    required this.type,
    required this.title,
    this.body,
    this.referenceId,
    required this.isRead,
    required this.createdAt,
  });
}

@immutable
class GetUserNotificationsData {
  final List<GetUserNotificationsNotifications> notifications;
  GetUserNotificationsData.fromJson(dynamic json):
  
  notifications = (json['notifications'] as List<dynamic>)
        .map((e) => GetUserNotificationsNotifications.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserNotificationsData otherTyped = other as GetUserNotificationsData;
    return notifications == otherTyped.notifications;
    
  }
  @override
  int get hashCode => notifications.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['notifications'] = notifications.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserNotificationsData({
    required this.notifications,
  });
}

@immutable
class GetUserNotificationsVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserNotificationsVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserNotificationsVariables otherTyped = other as GetUserNotificationsVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetUserNotificationsVariables({
    required this.userId,
  });
}

