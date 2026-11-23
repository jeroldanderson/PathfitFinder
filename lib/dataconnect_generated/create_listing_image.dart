part of 'generated.dart';

class CreateListingImageVariablesBuilder {
  String listingId;
  String imageUrl;
  bool isPrimary;
  int displayOrder;

  final FirebaseDataConnect _dataConnect;
  CreateListingImageVariablesBuilder(this._dataConnect, {required  this.listingId,required  this.imageUrl,required  this.isPrimary,required  this.displayOrder,});
  Deserializer<CreateListingImageData> dataDeserializer = (dynamic json)  => CreateListingImageData.fromJson(jsonDecode(json));
  Serializer<CreateListingImageVariables> varsSerializer = (CreateListingImageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateListingImageData, CreateListingImageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateListingImageData, CreateListingImageVariables> ref() {
    CreateListingImageVariables vars= CreateListingImageVariables(listingId: listingId,imageUrl: imageUrl,isPrimary: isPrimary,displayOrder: displayOrder,);
    return _dataConnect.mutation("CreateListingImage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateListingImageListingImageInsert {
  final String id;
  CreateListingImageListingImageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingImageListingImageInsert otherTyped = other as CreateListingImageListingImageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateListingImageListingImageInsert({
    required this.id,
  });
}

@immutable
class CreateListingImageData {
  final CreateListingImageListingImageInsert listingImage_insert;
  CreateListingImageData.fromJson(dynamic json):
  
  listingImage_insert = CreateListingImageListingImageInsert.fromJson(json['listingImage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateListingImageData otherTyped = other as CreateListingImageData;
    return listingImage_insert == otherTyped.listingImage_insert;
    
  }
  @override
  int get hashCode => listingImage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listingImage_insert'] = listingImage_insert.toJson();
    return json;
  }

  CreateListingImageData({
    required this.listingImage_insert,
  });
}

@immutable
class CreateListingImageVariables {
  final String listingId;
  final String imageUrl;
  final bool isPrimary;
  final int displayOrder;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateListingImageVariables.fromJson(Map<String, dynamic> json):
  
  listingId = nativeFromJson<String>(json['listingId']),
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

    final CreateListingImageVariables otherTyped = other as CreateListingImageVariables;
    return listingId == otherTyped.listingId && 
    imageUrl == otherTyped.imageUrl && 
    isPrimary == otherTyped.isPrimary && 
    displayOrder == otherTyped.displayOrder;
    
  }
  @override
  int get hashCode => Object.hashAll([listingId.hashCode, imageUrl.hashCode, isPrimary.hashCode, displayOrder.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['listingId'] = nativeToJson<String>(listingId);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    json['isPrimary'] = nativeToJson<bool>(isPrimary);
    json['displayOrder'] = nativeToJson<int>(displayOrder);
    return json;
  }

  CreateListingImageVariables({
    required this.listingId,
    required this.imageUrl,
    required this.isPrimary,
    required this.displayOrder,
  });
}

