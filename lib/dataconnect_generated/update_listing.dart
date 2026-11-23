part of 'generated.dart';

class UpdateListingVariablesBuilder {
  String id;
  Optional<String> _title = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  Optional<double> _price = Optional.optional(nativeFromJson, nativeToJson);
  Optional<UniformType> _uniformType = Optional.optional((data) => UniformType.values.byName(data), enumSerializer);
  Optional<UniformSizeType> _size = Optional.optional((data) => UniformSizeType.values.byName(data), enumSerializer);
  Optional<UniformSetType> _setType = Optional.optional((data) => UniformSetType.values.byName(data), enumSerializer);
  Optional<OwnerGenderType> _previousOwnerGender = Optional.optional((data) => OwnerGenderType.values.byName(data), enumSerializer);
  Optional<bool> _hasAssignedNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<ItemConditionType> _condition = Optional.optional((data) => ItemConditionType.values.byName(data), enumSerializer);
  Optional<ListingStatus> _status = Optional.optional((data) => ListingStatus.values.byName(data), enumSerializer);

  final FirebaseDataConnect _dataConnect;  UpdateListingVariablesBuilder title(String? t) {
   _title.value = t;
   return this;
  }
  UpdateListingVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }
  UpdateListingVariablesBuilder price(double? t) {
   _price.value = t;
   return this;
  }
  UpdateListingVariablesBuilder uniformType(UniformType? t) {
   _uniformType.value = t;
   return this;
  }
  UpdateListingVariablesBuilder size(UniformSizeType? t) {
   _size.value = t;
   return this;
  }
  UpdateListingVariablesBuilder setType(UniformSetType? t) {
   _setType.value = t;
   return this;
  }
  UpdateListingVariablesBuilder previousOwnerGender(OwnerGenderType? t) {
   _previousOwnerGender.value = t;
   return this;
  }
  UpdateListingVariablesBuilder hasAssignedNumber(bool? t) {
   _hasAssignedNumber.value = t;
   return this;
  }
  UpdateListingVariablesBuilder condition(ItemConditionType? t) {
   _condition.value = t;
   return this;
  }
  UpdateListingVariablesBuilder status(ListingStatus? t) {
   _status.value = t;
   return this;
  }

  UpdateListingVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateListingData> dataDeserializer = (dynamic json)  => UpdateListingData.fromJson(jsonDecode(json));
  Serializer<UpdateListingVariables> varsSerializer = (UpdateListingVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateListingData, UpdateListingVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateListingData, UpdateListingVariables> ref() {
    UpdateListingVariables vars= UpdateListingVariables(id: id,title: _title,description: _description,price: _price,uniformType: _uniformType,size: _size,setType: _setType,previousOwnerGender: _previousOwnerGender,hasAssignedNumber: _hasAssignedNumber,condition: _condition,status: _status,);
    return _dataConnect.mutation("UpdateListing", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateListingListingUpdate {
  final String id;
  UpdateListingListingUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateListingListingUpdate otherTyped = other as UpdateListingListingUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateListingListingUpdate({
    required this.id,
  });
}

@immutable
class UpdateListingData {
  final UpdateListingListingUpdate? listing_update;
  UpdateListingData.fromJson(dynamic json):
  
  listing_update = json['listing_update'] == null ? null : UpdateListingListingUpdate.fromJson(json['listing_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateListingData otherTyped = other as UpdateListingData;
    return listing_update == otherTyped.listing_update;
    
  }
  @override
  int get hashCode => listing_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (listing_update != null) {
      json['listing_update'] = listing_update!.toJson();
    }
    return json;
  }

  UpdateListingData({
    this.listing_update,
  });
}

@immutable
class UpdateListingVariables {
  final String id;
  late final Optional<String>title;
  late final Optional<String>description;
  late final Optional<double>price;
  late final Optional<UniformType>uniformType;
  late final Optional<UniformSizeType>size;
  late final Optional<UniformSetType>setType;
  late final Optional<OwnerGenderType>previousOwnerGender;
  late final Optional<bool>hasAssignedNumber;
  late final Optional<ItemConditionType>condition;
  late final Optional<ListingStatus>status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateListingVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    title = Optional.optional(nativeFromJson, nativeToJson);
    title.value = json['title'] == null ? null : nativeFromJson<String>(json['title']);
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  
    price = Optional.optional(nativeFromJson, nativeToJson);
    price.value = json['price'] == null ? null : nativeFromJson<double>(json['price']);
  
  
    uniformType = Optional.optional((data) => UniformType.values.byName(data), enumSerializer);
    uniformType.value = json['uniformType'] == null ? null : UniformType.values.byName(json['uniformType']);
  
  
    size = Optional.optional((data) => UniformSizeType.values.byName(data), enumSerializer);
    size.value = json['size'] == null ? null : UniformSizeType.values.byName(json['size']);
  
  
    setType = Optional.optional((data) => UniformSetType.values.byName(data), enumSerializer);
    setType.value = json['setType'] == null ? null : UniformSetType.values.byName(json['setType']);
  
  
    previousOwnerGender = Optional.optional((data) => OwnerGenderType.values.byName(data), enumSerializer);
    previousOwnerGender.value = json['previousOwnerGender'] == null ? null : OwnerGenderType.values.byName(json['previousOwnerGender']);
  
  
    hasAssignedNumber = Optional.optional(nativeFromJson, nativeToJson);
    hasAssignedNumber.value = json['hasAssignedNumber'] == null ? null : nativeFromJson<bool>(json['hasAssignedNumber']);
  
  
    condition = Optional.optional((data) => ItemConditionType.values.byName(data), enumSerializer);
    condition.value = json['condition'] == null ? null : ItemConditionType.values.byName(json['condition']);
  
  
    status = Optional.optional((data) => ListingStatus.values.byName(data), enumSerializer);
    status.value = json['status'] == null ? null : ListingStatus.values.byName(json['status']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateListingVariables otherTyped = other as UpdateListingVariables;
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
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode, description.hashCode, price.hashCode, uniformType.hashCode, size.hashCode, setType.hashCode, previousOwnerGender.hashCode, hasAssignedNumber.hashCode, condition.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(title.state == OptionalState.set) {
      json['title'] = title.toJson();
    }
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    if(price.state == OptionalState.set) {
      json['price'] = price.toJson();
    }
    if(uniformType.state == OptionalState.set) {
      json['uniformType'] = uniformType.toJson();
    }
    if(size.state == OptionalState.set) {
      json['size'] = size.toJson();
    }
    if(setType.state == OptionalState.set) {
      json['setType'] = setType.toJson();
    }
    if(previousOwnerGender.state == OptionalState.set) {
      json['previousOwnerGender'] = previousOwnerGender.toJson();
    }
    if(hasAssignedNumber.state == OptionalState.set) {
      json['hasAssignedNumber'] = hasAssignedNumber.toJson();
    }
    if(condition.state == OptionalState.set) {
      json['condition'] = condition.toJson();
    }
    if(status.state == OptionalState.set) {
      json['status'] = status.toJson();
    }
    return json;
  }

  UpdateListingVariables({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.uniformType,
    required this.size,
    required this.setType,
    required this.previousOwnerGender,
    required this.hasAssignedNumber,
    required this.condition,
    required this.status,
  });
}

