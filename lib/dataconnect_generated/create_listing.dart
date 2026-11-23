part of 'generated.dart';

class CreateListingVariablesBuilder {
  String sellerId;
  String title;
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  double price;
  UniformType uniformType;
  UniformSizeType size;
  UniformSetType setType;
  OwnerGenderType previousOwnerGender;
  bool hasAssignedNumber;
  ItemConditionType condition;

  final FirebaseDataConnect _dataConnect;  CreateListingVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  CreateListingVariablesBuilder(this._dataConnect, {required  this.sellerId,required  this.title,required  this.price,required  this.uniformType,required  this.size,required  this.setType,required  this.previousOwnerGender,required  this.hasAssignedNumber,required  this.condition,});
  Deserializer<CreateListingData> dataDeserializer = (dynamic json)  => CreateListingData.fromJson(jsonDecode(json));
  Serializer<CreateListingVariables> varsSerializer = (CreateListingVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateListingData, CreateListingVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateListingData, CreateListingVariables> ref() {
    CreateListingVariables vars= CreateListingVariables(sellerId: sellerId,title: title,description: _description,price: price,uniformType: uniformType,size: size,setType: setType,previousOwnerGender: previousOwnerGender,hasAssignedNumber: hasAssignedNumber,condition: condition,);
    return _dataConnect.mutation("CreateListing", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateListingListingInsert {
  final String id;
  CreateListingListingInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingListingInsert otherTyped = other as CreateListingListingInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateListingListingInsert({
    required this.id,
  });
}

@immutable
class CreateListingData {
  final CreateListingListingInsert listing_insert;
  CreateListingData.fromJson(dynamic json):
  
  listing_insert = CreateListingListingInsert.fromJson(json['listing_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingData otherTyped = other as CreateListingData;
    return listing_insert == otherTyped.listing_insert;
    
  }
  @override
  int get hashCode => listing_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listing_insert'] = listing_insert.toJson();
    return json;
  }

  CreateListingData({
    required this.listing_insert,
  });
}

@immutable
class CreateListingVariables {
  final String sellerId;
  final String title;
  late final Optional<String>description;
  final double price;
  final UniformType uniformType;
  final UniformSizeType size;
  final UniformSetType setType;
  final OwnerGenderType previousOwnerGender;
  final bool hasAssignedNumber;
  final ItemConditionType condition;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateListingVariables.fromJson(Map<String, dynamic> json):
  
  sellerId = nativeFromJson<String>(json['sellerId']),
  title = nativeFromJson<String>(json['title']),
  price = nativeFromJson<double>(json['price']),
  uniformType = UniformType.values.byName(json['uniformType']),
  size = UniformSizeType.values.byName(json['size']),
  setType = UniformSetType.values.byName(json['setType']),
  previousOwnerGender = OwnerGenderType.values.byName(json['previousOwnerGender']),
  hasAssignedNumber = nativeFromJson<bool>(json['hasAssignedNumber']),
  condition = ItemConditionType.values.byName(json['condition']) {
  
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  
  
  
  
  
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingVariables otherTyped = other as CreateListingVariables;
    return sellerId == otherTyped.sellerId && 
    title == otherTyped.title && 
    description == otherTyped.description && 
    price == otherTyped.price && 
    uniformType == otherTyped.uniformType && 
    size == otherTyped.size && 
    setType == otherTyped.setType && 
    previousOwnerGender == otherTyped.previousOwnerGender && 
    hasAssignedNumber == otherTyped.hasAssignedNumber && 
    condition == otherTyped.condition;
    
  }
  @override
  int get hashCode => Object.hashAll([sellerId.hashCode, title.hashCode, description.hashCode, price.hashCode, uniformType.hashCode, size.hashCode, setType.hashCode, previousOwnerGender.hashCode, hasAssignedNumber.hashCode, condition.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sellerId'] = nativeToJson<String>(sellerId);
    json['title'] = nativeToJson<String>(title);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    json['price'] = nativeToJson<double>(price);
    json['uniformType'] = 
    uniformType.name
    ;
    json['size'] = 
    size.name
    ;
    json['setType'] = 
    setType.name
    ;
    json['previousOwnerGender'] = 
    previousOwnerGender.name
    ;
    json['hasAssignedNumber'] = nativeToJson<bool>(hasAssignedNumber);
    json['condition'] = 
    condition.name
    ;
    return json;
  }

  CreateListingVariables({
    required this.sellerId,
    required this.title,
    required this.description,
    required this.price,
    required this.uniformType,
    required this.size,
    required this.setType,
    required this.previousOwnerGender,
    required this.hasAssignedNumber,
    required this.condition,
  });
}

