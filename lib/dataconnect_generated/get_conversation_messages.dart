part of 'generated.dart';

class GetConversationMessagesVariablesBuilder {
  String conversationId;

  final FirebaseDataConnect _dataConnect;
  GetConversationMessagesVariablesBuilder(this._dataConnect, {required  this.conversationId,});
  Deserializer<GetConversationMessagesData> dataDeserializer = (dynamic json)  => GetConversationMessagesData.fromJson(jsonDecode(json));
  Serializer<GetConversationMessagesVariables> varsSerializer = (GetConversationMessagesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetConversationMessagesData, GetConversationMessagesVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetConversationMessagesData, GetConversationMessagesVariables> ref() {
    GetConversationMessagesVariables vars= GetConversationMessagesVariables(conversationId: conversationId,);
    return _dataConnect.query("GetConversationMessages", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetConversationMessagesMessages {
  final String id;
  final String content;
  final bool isRead;
  final Timestamp sentAt;
  final GetConversationMessagesMessagesSender sender;
  GetConversationMessagesMessages.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  content = nativeFromJson<String>(json['content']),
  isRead = nativeFromJson<bool>(json['isRead']),
  sentAt = Timestamp.fromJson(json['sentAt']),
  sender = GetConversationMessagesMessagesSender.fromJson(json['sender']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetConversationMessagesMessages otherTyped = other as GetConversationMessagesMessages;
    return id == otherTyped.id && 
    content == otherTyped.content && 
    isRead == otherTyped.isRead && 
    sentAt == otherTyped.sentAt && 
    sender == otherTyped.sender;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, content.hashCode, isRead.hashCode, sentAt.hashCode, sender.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['content'] = nativeToJson<String>(content);
    json['isRead'] = nativeToJson<bool>(isRead);
    json['sentAt'] = sentAt.toJson();
    json['sender'] = sender.toJson();
    return json;
  }

  GetConversationMessagesMessages({
    required this.id,
    required this.content,
    required this.isRead,
    required this.sentAt,
    required this.sender,
  });
}

@immutable
class GetConversationMessagesMessagesSender {
  final String id;
  final String email;
  final String fullName;
  GetConversationMessagesMessagesSender.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  email = nativeFromJson<String>(json['email']),
  fullName = nativeFromJson<String>(json['fullName']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetConversationMessagesMessagesSender otherTyped = other as GetConversationMessagesMessagesSender;
    return id == otherTyped.id && 
    email == otherTyped.email && 
    fullName == otherTyped.fullName;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, email.hashCode, fullName.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['email'] = nativeToJson<String>(email);
    json['fullName'] = nativeToJson<String>(fullName);
    return json;
  }

  GetConversationMessagesMessagesSender({
    required this.id,
    required this.email,
    required this.fullName,
  });
}

@immutable
class GetConversationMessagesData {
  final List<GetConversationMessagesMessages> messages;
  GetConversationMessagesData.fromJson(dynamic json):
  
  messages = (json['messages'] as List<dynamic>)
        .map((e) => GetConversationMessagesMessages.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetConversationMessagesData otherTyped = other as GetConversationMessagesData;
    return messages == otherTyped.messages;
    
  }
  @override
  int get hashCode => messages.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['messages'] = messages.map((e) => e.toJson()).toList();
    return json;
  }

  GetConversationMessagesData({
    required this.messages,
  });
}

@immutable
class GetConversationMessagesVariables {
  final String conversationId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetConversationMessagesVariables.fromJson(Map<String, dynamic> json):
  
  conversationId = nativeFromJson<String>(json['conversationId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetConversationMessagesVariables otherTyped = other as GetConversationMessagesVariables;
    return conversationId == otherTyped.conversationId;
    
  }
  @override
  int get hashCode => conversationId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['conversationId'] = nativeToJson<String>(conversationId);
    return json;
  }

  GetConversationMessagesVariables({
    required this.conversationId,
  });
}

