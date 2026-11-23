library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

part 'create_user.dart';

part 'create_verification_submission.dart';

part 'create_listing.dart';

part 'create_listing_image.dart';

part 'update_listing.dart';

part 'create_listing_history.dart';

part 'soft_delete_listing.dart';

part 'create_conversation.dart';

part 'send_message.dart';

part 'update_conversation_timestamp.dart';

part 'mark_message_read.dart';

part 'create_notification.dart';

part 'mark_notification_read.dart';

part 'update_user_avatar.dart';

part 'update_user_profile.dart';

part 'review_verification_submission.dart';

part 'list_users.dart';

part 'get_user_by_email.dart';

part 'get_all_listings.dart';

part 'get_user_conversations.dart';

part 'get_conversation_messages.dart';

part 'get_user_notifications.dart';

part 'get_pending_verifications.dart';



  enum ItemConditionType {
    
      BRAND_NEW,
    
      LIKE_NEW,
    
      GENTLY_USED,
    
      USED_WITH_FLAWS,
    
  }
  
  String itemConditionTypeSerializer(EnumValue<ItemConditionType> e) {
    return e.stringValue;
  }
  EnumValue<ItemConditionType> itemConditionTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'BRAND_NEW':
        return const Known(ItemConditionType.BRAND_NEW);
      
      case 'LIKE_NEW':
        return const Known(ItemConditionType.LIKE_NEW);
      
      case 'GENTLY_USED':
        return const Known(ItemConditionType.GENTLY_USED);
      
      case 'USED_WITH_FLAWS':
        return const Known(ItemConditionType.USED_WITH_FLAWS);
      
      default:
        return Unknown(data);
    }
  }
  

  enum ListingStatus {
    
      AVAILABLE,
    
      RESERVED,
    
      SOLD,
    
  }
  
  String listingStatusSerializer(EnumValue<ListingStatus> e) {
    return e.stringValue;
  }
  EnumValue<ListingStatus> listingStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'AVAILABLE':
        return const Known(ListingStatus.AVAILABLE);
      
      case 'RESERVED':
        return const Known(ListingStatus.RESERVED);
      
      case 'SOLD':
        return const Known(ListingStatus.SOLD);
      
      default:
        return Unknown(data);
    }
  }
  

  enum NotificationType {
    
      NEW_MESSAGE,
    
      VERIFICATION_UPDATE,
    
      PRICE_DROP,
    
      LISTING_SOLD,
    
  }
  
  String notificationTypeSerializer(EnumValue<NotificationType> e) {
    return e.stringValue;
  }
  EnumValue<NotificationType> notificationTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'NEW_MESSAGE':
        return const Known(NotificationType.NEW_MESSAGE);
      
      case 'VERIFICATION_UPDATE':
        return const Known(NotificationType.VERIFICATION_UPDATE);
      
      case 'PRICE_DROP':
        return const Known(NotificationType.PRICE_DROP);
      
      case 'LISTING_SOLD':
        return const Known(NotificationType.LISTING_SOLD);
      
      default:
        return Unknown(data);
    }
  }
  

  enum OwnerGenderType {
    
      WOMAN_OWNED,
    
      MAN_OWNED,
    
  }
  
  String ownerGenderTypeSerializer(EnumValue<OwnerGenderType> e) {
    return e.stringValue;
  }
  EnumValue<OwnerGenderType> ownerGenderTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'WOMAN_OWNED':
        return const Known(OwnerGenderType.WOMAN_OWNED);
      
      case 'MAN_OWNED':
        return const Known(OwnerGenderType.MAN_OWNED);
      
      default:
        return Unknown(data);
    }
  }
  

  enum UniformSetType {
    
      COMPLETE_SET,
    
      TOP_ONLY,
    
      BOTTOM_ONLY,
    
  }
  
  String uniformSetTypeSerializer(EnumValue<UniformSetType> e) {
    return e.stringValue;
  }
  EnumValue<UniformSetType> uniformSetTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'COMPLETE_SET':
        return const Known(UniformSetType.COMPLETE_SET);
      
      case 'TOP_ONLY':
        return const Known(UniformSetType.TOP_ONLY);
      
      case 'BOTTOM_ONLY':
        return const Known(UniformSetType.BOTTOM_ONLY);
      
      default:
        return Unknown(data);
    }
  }
  

  enum UniformSizeType {
    
      XS,
    
      S,
    
      M,
    
      L,
    
      XL,
    
      SIZE_2XL,
    
      SIZE_3XL,
    
  }
  
  String uniformSizeTypeSerializer(EnumValue<UniformSizeType> e) {
    return e.stringValue;
  }
  EnumValue<UniformSizeType> uniformSizeTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'XS':
        return const Known(UniformSizeType.XS);
      
      case 'S':
        return const Known(UniformSizeType.S);
      
      case 'M':
        return const Known(UniformSizeType.M);
      
      case 'L':
        return const Known(UniformSizeType.L);
      
      case 'XL':
        return const Known(UniformSizeType.XL);
      
      case 'SIZE_2XL':
        return const Known(UniformSizeType.SIZE_2XL);
      
      case 'SIZE_3XL':
        return const Known(UniformSizeType.SIZE_3XL);
      
      default:
        return Unknown(data);
    }
  }
  

  enum UniformType {
    
      REGULAR_PATHFIT,
    
      SWIMMING,
    
      ARNIS,
    
      MARTIAL_ARTS,
    
      DANCE,
    
      TEAM_SPORTS,
    
      OTHER,
    
  }
  
  String uniformTypeSerializer(EnumValue<UniformType> e) {
    return e.stringValue;
  }
  EnumValue<UniformType> uniformTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'REGULAR_PATHFIT':
        return const Known(UniformType.REGULAR_PATHFIT);
      
      case 'SWIMMING':
        return const Known(UniformType.SWIMMING);
      
      case 'ARNIS':
        return const Known(UniformType.ARNIS);
      
      case 'MARTIAL_ARTS':
        return const Known(UniformType.MARTIAL_ARTS);
      
      case 'DANCE':
        return const Known(UniformType.DANCE);
      
      case 'TEAM_SPORTS':
        return const Known(UniformType.TEAM_SPORTS);
      
      case 'OTHER':
        return const Known(UniformType.OTHER);
      
      default:
        return Unknown(data);
    }
  }
  

  enum UserRole {
    
      STUDENT,
    
      ALUMNI,
    
      ADMIN,
    
  }
  
  String userRoleSerializer(EnumValue<UserRole> e) {
    return e.stringValue;
  }
  EnumValue<UserRole> userRoleDeserializer(dynamic data) {
    switch (data) {
      
      case 'STUDENT':
        return const Known(UserRole.STUDENT);
      
      case 'ALUMNI':
        return const Known(UserRole.ALUMNI);
      
      case 'ADMIN':
        return const Known(UserRole.ADMIN);
      
      default:
        return Unknown(data);
    }
  }
  

  enum VerificationDocType {
    
      REG_FORM,
    
      UST_ID,
    
  }
  
  String verificationDocTypeSerializer(EnumValue<VerificationDocType> e) {
    return e.stringValue;
  }
  EnumValue<VerificationDocType> verificationDocTypeDeserializer(dynamic data) {
    switch (data) {
      
      case 'REG_FORM':
        return const Known(VerificationDocType.REG_FORM);
      
      case 'UST_ID':
        return const Known(VerificationDocType.UST_ID);
      
      default:
        return Unknown(data);
    }
  }
  

  enum VerificationStatus {
    
      UNVERIFIED,
    
      PENDING,
    
      VERIFIED,
    
      REJECTED,
    
  }
  
  String verificationStatusSerializer(EnumValue<VerificationStatus> e) {
    return e.stringValue;
  }
  EnumValue<VerificationStatus> verificationStatusDeserializer(dynamic data) {
    switch (data) {
      
      case 'UNVERIFIED':
        return const Known(VerificationStatus.UNVERIFIED);
      
      case 'PENDING':
        return const Known(VerificationStatus.PENDING);
      
      case 'VERIFIED':
        return const Known(VerificationStatus.VERIFIED);
      
      case 'REJECTED':
        return const Known(VerificationStatus.REJECTED);
      
      default:
        return Unknown(data);
    }
  }
  



String enumSerializer(Enum e) {
  return e.name;
}



/// A sealed class representing either a known enum value or an unknown string value.
@immutable
sealed class EnumValue<T extends Enum> {
  const EnumValue();

  

  /// The string representation of the value.
  String get stringValue;
  @override
  String toString() {
    return "EnumValue($stringValue)";
  }
}

/// Represents a known, valid enum value.
class Known<T extends Enum> extends EnumValue<T> {
  /// The actual enum value.
  final T value;

  const Known(this.value);

  @override
  String get stringValue => value.name;

  @override
  String toString() {
    return "Known($stringValue)";
  }
}
/// Represents an unknown or unrecognized enum value.
class Unknown extends EnumValue<Never> {
  /// The raw string value that couldn't be mapped to a known enum.
  @override
  final String stringValue;

  const Unknown(this.stringValue);
  @override
  String toString() {
    return "Unknown($stringValue)";
  }
}

class ExampleConnector {
  
  
  CreateUserVariablesBuilder createUser ({required String email, required String fullName, }) {
    return CreateUserVariablesBuilder(dataConnect, email: email,fullName: fullName,);
  }
  
  
  CreateVerificationSubmissionVariablesBuilder createVerificationSubmission ({required String userId, required VerificationDocType documentType, required String documentUrl, }) {
    return CreateVerificationSubmissionVariablesBuilder(dataConnect, userId: userId,documentType: documentType,documentUrl: documentUrl,);
  }
  
  
  CreateListingVariablesBuilder createListing ({required String sellerId, required String title, required double price, required UniformType uniformType, required UniformSizeType size, required UniformSetType setType, required OwnerGenderType previousOwnerGender, required bool hasAssignedNumber, required ItemConditionType condition, }) {
    return CreateListingVariablesBuilder(dataConnect, sellerId: sellerId,title: title,price: price,uniformType: uniformType,size: size,setType: setType,previousOwnerGender: previousOwnerGender,hasAssignedNumber: hasAssignedNumber,condition: condition,);
  }
  
  
  CreateListingImageVariablesBuilder createListingImage ({required String listingId, required String imageUrl, required bool isPrimary, required int displayOrder, }) {
    return CreateListingImageVariablesBuilder(dataConnect, listingId: listingId,imageUrl: imageUrl,isPrimary: isPrimary,displayOrder: displayOrder,);
  }
  
  
  UpdateListingVariablesBuilder updateListing ({required String id, }) {
    return UpdateListingVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CreateListingHistoryVariablesBuilder createListingHistory ({required String listingId, required String changedById, required String fieldName, }) {
    return CreateListingHistoryVariablesBuilder(dataConnect, listingId: listingId,changedById: changedById,fieldName: fieldName,);
  }
  
  
  SoftDeleteListingVariablesBuilder softDeleteListing ({required String id, }) {
    return SoftDeleteListingVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CreateConversationVariablesBuilder createConversation ({required String listingId, required String buyerId, required String sellerId, }) {
    return CreateConversationVariablesBuilder(dataConnect, listingId: listingId,buyerId: buyerId,sellerId: sellerId,);
  }
  
  
  SendMessageVariablesBuilder sendMessage ({required String conversationId, required String senderId, required String content, }) {
    return SendMessageVariablesBuilder(dataConnect, conversationId: conversationId,senderId: senderId,content: content,);
  }
  
  
  UpdateConversationTimestampVariablesBuilder updateConversationTimestamp ({required String id, }) {
    return UpdateConversationTimestampVariablesBuilder(dataConnect, id: id,);
  }
  
  
  MarkMessageReadVariablesBuilder markMessageRead ({required String id, }) {
    return MarkMessageReadVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CreateNotificationVariablesBuilder createNotification ({required String userId, required NotificationType type, required String title, }) {
    return CreateNotificationVariablesBuilder(dataConnect, userId: userId,type: type,title: title,);
  }
  
  
  MarkNotificationReadVariablesBuilder markNotificationRead ({required String id, }) {
    return MarkNotificationReadVariablesBuilder(dataConnect, id: id,);
  }
  
  
  UpdateUserAvatarVariablesBuilder updateUserAvatar ({required String id, required String avatarUrl, }) {
    return UpdateUserAvatarVariablesBuilder(dataConnect, id: id,avatarUrl: avatarUrl,);
  }
  
  
  UpdateUserProfileVariablesBuilder updateUserProfile ({required String id, required String fullName, }) {
    return UpdateUserProfileVariablesBuilder(dataConnect, id: id,fullName: fullName,);
  }
  
  
  ReviewVerificationSubmissionVariablesBuilder reviewVerificationSubmission ({required String userId, required String submissionId, required VerificationStatus status, }) {
    return ReviewVerificationSubmissionVariablesBuilder(dataConnect, userId: userId,submissionId: submissionId,status: status,);
  }
  
  
  ListUsersVariablesBuilder listUsers () {
    return ListUsersVariablesBuilder(dataConnect, );
  }
  
  
  GetUserByEmailVariablesBuilder getUserByEmail ({required String email, }) {
    return GetUserByEmailVariablesBuilder(dataConnect, email: email,);
  }
  
  
  GetAllListingsVariablesBuilder getAllListings () {
    return GetAllListingsVariablesBuilder(dataConnect, );
  }
  
  
  GetUserConversationsVariablesBuilder getUserConversations ({required String userId, }) {
    return GetUserConversationsVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetConversationMessagesVariablesBuilder getConversationMessages ({required String conversationId, }) {
    return GetConversationMessagesVariablesBuilder(dataConnect, conversationId: conversationId,);
  }
  
  
  GetUserNotificationsVariablesBuilder getUserNotifications ({required String userId, }) {
    return GetUserNotificationsVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetPendingVerificationsVariablesBuilder getPendingVerifications () {
    return GetPendingVerificationsVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-southeast1',
    'example',
    'pathfitfinder',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    
    CacheSettings cacheSettings = CacheSettings(
      maxAge: Duration(milliseconds:0),
      storage: CacheStorage.persistent,
    );
    
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            cacheSettings: cacheSettings,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
