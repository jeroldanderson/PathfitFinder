part of 'generated.dart';

class GetUserConversationsVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetUserConversationsVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetUserConversationsData> dataDeserializer = (dynamic json)  => GetUserConversationsData.fromJson(jsonDecode(json));
  Serializer<GetUserConversationsVariables> varsSerializer = (GetUserConversationsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserConversationsData, GetUserConversationsVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetUserConversationsData, GetUserConversationsVariables> ref() {
    GetUserConversationsVariables vars= GetUserConversationsVariables(userId: userId,);
    return _dataConnect.query("GetUserConversations", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserConversationsConversations {
  final String id;
  final Timestamp lastMessageAt;
  final GetUserConversationsConversationsListing listing;
  final GetUserConversationsConversationsBuyer buyer;
  final GetUserConversationsConversationsSeller seller;
  final List<GetUserConversationsConversationsMessages> messages;
  GetUserConversationsConversations.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  lastMessageAt = Timestamp.fromJson(json['lastMessageAt']),
  listing = GetUserConversationsConversationsListing.fromJson(json['listing']),
  buyer = GetUserConversationsConversationsBuyer.fromJson(json['buyer']),
  seller = GetUserConversationsConversationsSeller.fromJson(json['seller']),
  messages = (json['messages'] as List<dynamic>)
        .map((e) => GetUserConversationsConversationsMessages.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsConversations otherTyped = other as GetUserConversationsConversations;
    return id == otherTyped.id && 
    lastMessageAt == otherTyped.lastMessageAt && 
    listing == otherTyped.listing && 
    buyer == otherTyped.buyer && 
    seller == otherTyped.seller && 
    messages == otherTyped.messages;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, lastMessageAt.hashCode, listing.hashCode, buyer.hashCode, seller.hashCode, messages.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['lastMessageAt'] = lastMessageAt.toJson();
    json['listing'] = listing.toJson();
    json['buyer'] = buyer.toJson();
    json['seller'] = seller.toJson();
    json['messages'] = messages.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserConversationsConversations({
    required this.id,
    required this.lastMessageAt,
    required this.listing,
    required this.buyer,
    required this.seller,
    required this.messages,
  });
}

@immutable
class GetUserConversationsConversationsListing {
  final String id;
  final String title;
  final double price;
  final EnumValue<UniformSizeType> size;
  final EnumValue<ItemConditionType> condition;
  final EnumValue<ListingStatus> status;
  final Timestamp? deletedAt;
  final List<GetUserConversationsConversationsListingCoverImages> coverImages;
  GetUserConversationsConversationsListing.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = nativeFromJson<String>(json['title']),
  price = nativeFromJson<double>(json['price']),
  size = uniformSizeTypeDeserializer(json['size']),
  condition = itemConditionTypeDeserializer(json['condition']),
  status = listingStatusDeserializer(json['status']),
  deletedAt = json['deletedAt'] == null ? null : Timestamp.fromJson(json['deletedAt']),
  coverImages = (json['coverImages'] as List<dynamic>)
        .map((e) => GetUserConversationsConversationsListingCoverImages.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsConversationsListing otherTyped = other as GetUserConversationsConversationsListing;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    price == otherTyped.price && 
    size == otherTyped.size && 
    condition == otherTyped.condition && 
    status == otherTyped.status && 
    deletedAt == otherTyped.deletedAt && 
    coverImages == otherTyped.coverImages;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, price.hashCode, size.hashCode, condition.hashCode, status.hashCode, deletedAt.hashCode, coverImages.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['title'] = nativeToJson<String>(title);
    json['price'] = nativeToJson<double>(price);
    json['size'] = 
    uniformSizeTypeSerializer(size)
    ;
    json['condition'] = 
    itemConditionTypeSerializer(condition)
    ;
    json['status'] = 
    listingStatusSerializer(status)
    ;
    if (deletedAt != null) {
      json['deletedAt'] = deletedAt!.toJson();
    }
    json['coverImages'] = coverImages.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserConversationsConversationsListing({
    required this.id,
    required this.title,
    required this.price,
    required this.size,
    required this.condition,
    required this.status,
    this.deletedAt,
    required this.coverImages,
  });
}

@immutable
class GetUserConversationsConversationsListingCoverImages {
  final String imageUrl;
  GetUserConversationsConversationsListingCoverImages.fromJson(dynamic json):
  
  imageUrl = nativeFromJson<String>(json['imageUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsConversationsListingCoverImages otherTyped = other as GetUserConversationsConversationsListingCoverImages;
    return imageUrl == otherTyped.imageUrl;
    
  }
  @override
  int get hashCode => imageUrl.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    return json;
  }

  GetUserConversationsConversationsListingCoverImages({
    required this.imageUrl,
  });
}

@immutable
class GetUserConversationsConversationsBuyer {
  final String id;
  final String email;
  final String fullName;
  GetUserConversationsConversationsBuyer.fromJson(dynamic json):
  
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

    final GetUserConversationsConversationsBuyer otherTyped = other as GetUserConversationsConversationsBuyer;
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

  GetUserConversationsConversationsBuyer({
    required this.id,
    required this.email,
    required this.fullName,
  });
}

@immutable
class GetUserConversationsConversationsSeller {
  final String id;
  final String email;
  final String fullName;
  final EnumValue<VerificationStatus> verificationStatus;
  GetUserConversationsConversationsSeller.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  email = nativeFromJson<String>(json['email']),
  fullName = nativeFromJson<String>(json['fullName']),
  verificationStatus = verificationStatusDeserializer(json['verificationStatus']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsConversationsSeller otherTyped = other as GetUserConversationsConversationsSeller;
    return id == otherTyped.id && 
    email == otherTyped.email && 
    fullName == otherTyped.fullName && 
    verificationStatus == otherTyped.verificationStatus;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, email.hashCode, fullName.hashCode, verificationStatus.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['email'] = nativeToJson<String>(email);
    json['fullName'] = nativeToJson<String>(fullName);
    json['verificationStatus'] = 
    verificationStatusSerializer(verificationStatus)
    ;
    return json;
  }

  GetUserConversationsConversationsSeller({
    required this.id,
    required this.email,
    required this.fullName,
    required this.verificationStatus,
  });
}

@immutable
class GetUserConversationsConversationsMessages {
  final String content;
  final bool isRead;
  final Timestamp sentAt;
  final GetUserConversationsConversationsMessagesSender sender;
  GetUserConversationsConversationsMessages.fromJson(dynamic json):
  
  content = nativeFromJson<String>(json['content']),
  isRead = nativeFromJson<bool>(json['isRead']),
  sentAt = Timestamp.fromJson(json['sentAt']),
  sender = GetUserConversationsConversationsMessagesSender.fromJson(json['sender']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsConversationsMessages otherTyped = other as GetUserConversationsConversationsMessages;
    return content == otherTyped.content && 
    isRead == otherTyped.isRead && 
    sentAt == otherTyped.sentAt && 
    sender == otherTyped.sender;
    
  }
  @override
  int get hashCode => Object.hashAll([content.hashCode, isRead.hashCode, sentAt.hashCode, sender.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['content'] = nativeToJson<String>(content);
    json['isRead'] = nativeToJson<bool>(isRead);
    json['sentAt'] = sentAt.toJson();
    json['sender'] = sender.toJson();
    return json;
  }

  GetUserConversationsConversationsMessages({
    required this.content,
    required this.isRead,
    required this.sentAt,
    required this.sender,
  });
}

@immutable
class GetUserConversationsConversationsMessagesSender {
  final String id;
  GetUserConversationsConversationsMessagesSender.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsConversationsMessagesSender otherTyped = other as GetUserConversationsConversationsMessagesSender;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetUserConversationsConversationsMessagesSender({
    required this.id,
  });
}

@immutable
class GetUserConversationsData {
  final List<GetUserConversationsConversations> conversations;
  GetUserConversationsData.fromJson(dynamic json):
  
  conversations = (json['conversations'] as List<dynamic>)
        .map((e) => GetUserConversationsConversations.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsData otherTyped = other as GetUserConversationsData;
    return conversations == otherTyped.conversations;
    
  }
  @override
  int get hashCode => conversations.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['conversations'] = conversations.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserConversationsData({
    required this.conversations,
  });
}

@immutable
class GetUserConversationsVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserConversationsVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserConversationsVariables otherTyped = other as GetUserConversationsVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetUserConversationsVariables({
    required this.userId,
  });
}

