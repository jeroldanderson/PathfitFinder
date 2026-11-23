part of 'generated.dart';

class SendMessageVariablesBuilder {
  String conversationId;
  String senderId;
  String content;

  final FirebaseDataConnect _dataConnect;
  SendMessageVariablesBuilder(this._dataConnect, {required  this.conversationId,required  this.senderId,required  this.content,});
  Deserializer<SendMessageData> dataDeserializer = (dynamic json)  => SendMessageData.fromJson(jsonDecode(json));
  Serializer<SendMessageVariables> varsSerializer = (SendMessageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SendMessageData, SendMessageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SendMessageData, SendMessageVariables> ref() {
    SendMessageVariables vars= SendMessageVariables(conversationId: conversationId,senderId: senderId,content: content,);
    return _dataConnect.mutation("SendMessage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SendMessageMessageInsert {
  final String id;
  SendMessageMessageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SendMessageMessageInsert otherTyped = other as SendMessageMessageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SendMessageMessageInsert({
    required this.id,
  });
}

@immutable
class SendMessageData {
  final SendMessageMessageInsert message_insert;
  SendMessageData.fromJson(dynamic json):
  
  message_insert = SendMessageMessageInsert.fromJson(json['message_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SendMessageData otherTyped = other as SendMessageData;
    return message_insert == otherTyped.message_insert;
    
  }
  @override
  int get hashCode => message_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['message_insert'] = message_insert.toJson();
    return json;
  }

  SendMessageData({
    required this.message_insert,
  });
}

@immutable
class SendMessageVariables {
  final String conversationId;
  final String senderId;
  final String content;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SendMessageVariables.fromJson(Map<String, dynamic> json):
  
  conversationId = nativeFromJson<String>(json['conversationId']),
  senderId = nativeFromJson<String>(json['senderId']),
  content = nativeFromJson<String>(json['content']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SendMessageVariables otherTyped = other as SendMessageVariables;
    return conversationId == otherTyped.conversationId && 
    senderId == otherTyped.senderId && 
    content == otherTyped.content;
    
  }
  @override
  int get hashCode => Object.hashAll([conversationId.hashCode, senderId.hashCode, content.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['conversationId'] = nativeToJson<String>(conversationId);
    json['senderId'] = nativeToJson<String>(senderId);
    json['content'] = nativeToJson<String>(content);
    return json;
  }

  SendMessageVariables({
    required this.conversationId,
    required this.senderId,
    required this.content,
  });
}

