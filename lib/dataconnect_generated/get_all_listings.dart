part of 'generated.dart';

class GetAllListingsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllListingsVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllListingsData> dataDeserializer = (dynamic json)  => GetAllListingsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllListingsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetAllListingsData, void> ref() {
    
    return _dataConnect.query("GetAllListings", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetAllListingsListings {
  final String id;
  final String title;
  final String? description;
  final double price;
  final EnumValue<UniformType> uniformType;
  final EnumValue<UniformSizeType> size;
  final EnumValue<UniformSetType> setType;
  final EnumValue<OwnerGenderType> previousOwnerGender;
  final bool hasAssignedNumber;
  final EnumValue<ItemConditionType> condition;
  final EnumValue<ListingStatus> status;
  final Timestamp createdAt;
  final GetAllListingsListingsSeller seller;
  final List<GetAllListingsListingsImages> images;
  GetAllListingsListings.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = nativeFromJson<String>(json['title']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  price = nativeFromJson<double>(json['price']),
  uniformType = uniformTypeDeserializer(json['uniformType']),
  size = uniformSizeTypeDeserializer(json['size']),
  setType = uniformSetTypeDeserializer(json['setType']),
  previousOwnerGender = ownerGenderTypeDeserializer(json['previousOwnerGender']),
  hasAssignedNumber = nativeFromJson<bool>(json['hasAssignedNumber']),
  condition = itemConditionTypeDeserializer(json['condition']),
  status = listingStatusDeserializer(json['status']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  seller = GetAllListingsListingsSeller.fromJson(json['seller']),
  images = (json['images'] as List<dynamic>)
        .map((e) => GetAllListingsListingsImages.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllListingsListings otherTyped = other as GetAllListingsListings;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    description == otherTyped.description && 
    price == otherTyped.price && 
    uniformType == otherTyped.uniformType && 
    size == otherTyped.size && 
    setType == otherTyped.setType && 
    previousOwnerGender == otherTyped.previousOwnerGender && 
    hasAssignedNumber == otherTyped.hasAssignedNumber && 
    condition == otherTyped.condition && 
    status == otherTyped.status && 
    createdAt == otherTyped.createdAt && 
    seller == otherTyped.seller && 
    images == otherTyped.images;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, description.hashCode, price.hashCode, uniformType.hashCode, size.hashCode, setType.hashCode, previousOwnerGender.hashCode, hasAssignedNumber.hashCode, condition.hashCode, status.hashCode, createdAt.hashCode, seller.hashCode, images.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['title'] = nativeToJson<String>(title);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    json['price'] = nativeToJson<double>(price);
    json['uniformType'] = 
    uniformTypeSerializer(uniformType)
    ;
    json['size'] = 
    uniformSizeTypeSerializer(size)
    ;
    json['setType'] = 
    uniformSetTypeSerializer(setType)
    ;
    json['previousOwnerGender'] = 
    ownerGenderTypeSerializer(previousOwnerGender)
    ;
    json['hasAssignedNumber'] = nativeToJson<bool>(hasAssignedNumber);
    json['condition'] = 
    itemConditionTypeSerializer(condition)
    ;
    json['status'] = 
    listingStatusSerializer(status)
    ;
    json['createdAt'] = createdAt.toJson();
    json['seller'] = seller.toJson();
    json['images'] = images.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllListingsListings({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    required this.uniformType,
    required this.size,
    required this.setType,
    required this.previousOwnerGender,
    required this.hasAssignedNumber,
    required this.condition,
    required this.status,
    required this.createdAt,
    required this.seller,
    required this.images,
  });
}

@immutable
class GetAllListingsListingsSeller {
  final String id;
  final String email;
  final String fullName;
  final String? collegeOrFaculty;
  final EnumValue<VerificationStatus> verificationStatus;
  final String? avatarUrl;
  GetAllListingsListingsSeller.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  email = nativeFromJson<String>(json['email']),
  fullName = nativeFromJson<String>(json['fullName']),
  collegeOrFaculty = json['collegeOrFaculty'] == null ? null : nativeFromJson<String>(json['collegeOrFaculty']),
  verificationStatus = verificationStatusDeserializer(json['verificationStatus']),
  avatarUrl = json['avatarUrl'] == null ? null : nativeFromJson<String>(json['avatarUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllListingsListingsSeller otherTyped = other as GetAllListingsListingsSeller;
    return id == otherTyped.id && 
    email == otherTyped.email && 
    fullName == otherTyped.fullName && 
    collegeOrFaculty == otherTyped.collegeOrFaculty && 
    verificationStatus == otherTyped.verificationStatus && 
    avatarUrl == otherTyped.avatarUrl;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, email.hashCode, fullName.hashCode, collegeOrFaculty.hashCode, verificationStatus.hashCode, avatarUrl.hashCode]);
  

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
    if (avatarUrl != null) {
      json['avatarUrl'] = nativeToJson<String?>(avatarUrl);
    }
    return json;
  }

  GetAllListingsListingsSeller({
    required this.id,
    required this.email,
    required this.fullName,
    this.collegeOrFaculty,
    required this.verificationStatus,
    this.avatarUrl,
  });
}

@immutable
class GetAllListingsListingsImages {
  final String id;
  final String imageUrl;
  final bool isPrimary;
  final int displayOrder;
  GetAllListingsListingsImages.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  isPrimary = nativeFromJson<bool>(json['isPrimary']),
  displayOrder = nativeFromJson<int>(json['displayOrder']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllListingsListingsImages otherTyped = other as GetAllListingsListingsImages;
    return id == otherTyped.id && 
    imageUrl == otherTyped.imageUrl && 
    isPrimary == otherTyped.isPrimary && 
    displayOrder == otherTyped.displayOrder;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, imageUrl.hashCode, isPrimary.hashCode, displayOrder.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['isPrimary'] = nativeToJson<bool>(isPrimary);
    json['displayOrder'] = nativeToJson<int>(displayOrder);
    return json;
  }

  GetAllListingsListingsImages({
    required this.id,
    required this.imageUrl,
    required this.isPrimary,
    required this.displayOrder,
  });
}

@immutable
class GetAllListingsData {
  final List<GetAllListingsListings> listings;
  GetAllListingsData.fromJson(dynamic json):
  
  listings = (json['listings'] as List<dynamic>)
        .map((e) => GetAllListingsListings.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllListingsData otherTyped = other as GetAllListingsData;
    return listings == otherTyped.listings;
    
  }
  @override
  int get hashCode => listings.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listings'] = listings.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllListingsData({
    required this.listings,
  });
}

