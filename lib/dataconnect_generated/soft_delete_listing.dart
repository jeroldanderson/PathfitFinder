part of 'generated.dart';

class SoftDeleteListingVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  SoftDeleteListingVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<SoftDeleteListingData> dataDeserializer = (dynamic json)  => SoftDeleteListingData.fromJson(jsonDecode(json));
  Serializer<SoftDeleteListingVariables> varsSerializer = (SoftDeleteListingVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<SoftDeleteListingData, SoftDeleteListingVariables>> execute() {
    return ref().execute();
  }

  MutationRef<SoftDeleteListingData, SoftDeleteListingVariables> ref() {
    SoftDeleteListingVariables vars= SoftDeleteListingVariables(id: id,);
    return _dataConnect.mutation("SoftDeleteListing", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SoftDeleteListingListingUpdate {
  final String id;
  SoftDeleteListingListingUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SoftDeleteListingListingUpdate otherTyped = other as SoftDeleteListingListingUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SoftDeleteListingListingUpdate({
    required this.id,
  });
}

@immutable
class SoftDeleteListingData {
  final SoftDeleteListingListingUpdate? listing_update;
  SoftDeleteListingData.fromJson(dynamic json):
  
  listing_update = json['listing_update'] == null ? null : SoftDeleteListingListingUpdate.fromJson(json['listing_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SoftDeleteListingData otherTyped = other as SoftDeleteListingData;
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

  SoftDeleteListingData({
    this.listing_update,
  });
}

@immutable
class SoftDeleteListingVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SoftDeleteListingVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SoftDeleteListingVariables otherTyped = other as SoftDeleteListingVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SoftDeleteListingVariables({
    required this.id,
  });
}

