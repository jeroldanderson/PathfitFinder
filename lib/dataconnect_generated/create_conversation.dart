part of 'generated.dart';

class CreateConversationVariablesBuilder {
  String listingId;
  String buyerId;
  String sellerId;

  final FirebaseDataConnect _dataConnect;
  CreateConversationVariablesBuilder(this._dataConnect, {required  this.listingId,required  this.buyerId,required  this.sellerId,});
  Deserializer<CreateConversationData> dataDeserializer = (dynamic json)  => CreateConversationData.fromJson(jsonDecode(json));
  Serializer<CreateConversationVariables> varsSerializer = (CreateConversationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateConversationData, CreateConversationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateConversationData, CreateConversationVariables> ref() {
    CreateConversationVariables vars= CreateConversationVariables(listingId: listingId,buyerId: buyerId,sellerId: sellerId,);
    return _dataConnect.mutation("CreateConversation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateConversationConversationInsert {
  final String id;
  CreateConversationConversationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateConversationConversationInsert otherTyped = other as CreateConversationConversationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateConversationConversationInsert({
    required this.id,
  });
}

@immutable
class CreateConversationData {
  final CreateConversationConversationInsert conversation_insert;
  CreateConversationData.fromJson(dynamic json):
  
  conversation_insert = CreateConversationConversationInsert.fromJson(json['conversation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateConversationData otherTyped = other as CreateConversationData;
    return conversation_insert == otherTyped.conversation_insert;
    
  }
  @override
  int get hashCode => conversation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['conversation_insert'] = conversation_insert.toJson();
    return json;
  }

  CreateConversationData({
    required this.conversation_insert,
  });
}

@immutable
class CreateConversationVariables {
  final String listingId;
  final String buyerId;
  final String sellerId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateConversationVariables.fromJson(Map<String, dynamic> json):
  
  listingId = nativeFromJson<String>(json['listingId']),
  buyerId = nativeFromJson<String>(json['buyerId']),
  sellerId = nativeFromJson<String>(json['sellerId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateConversationVariables otherTyped = other as CreateConversationVariables;
    return listingId == otherTyped.listingId && 
    buyerId == otherTyped.buyerId && 
    sellerId == otherTyped.sellerId;
    
  }
  @override
  int get hashCode => Object.hashAll([listingId.hashCode, buyerId.hashCode, sellerId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listingId'] = nativeToJson<String>(listingId);
    json['buyerId'] = nativeToJson<String>(buyerId);
    json['sellerId'] = nativeToJson<String>(sellerId);
    return json;
  }

  CreateConversationVariables({
    required this.listingId,
    required this.buyerId,
    required this.sellerId,
  });
}

