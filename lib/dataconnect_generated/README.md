# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### ListUsers
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listUsers();
ListUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listUsers().ref();
ref.execute();

ref.subscribe(...);
```


### GetUserByEmail
#### Required Arguments
```dart
String email = ...;
ExampleConnector.instance.getUserByEmail(
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserByEmailData, GetUserByEmailVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getUserByEmail(
  email: email,
);
GetUserByEmailData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = ExampleConnector.instance.getUserByEmail(
  email: email,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetAllListings
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getAllListings().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetAllListingsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getAllListings();
GetAllListingsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getAllListings().ref();
ref.execute();

ref.subscribe(...);
```


### GetUserConversations
#### Required Arguments
```dart
String userId = ...;
ExampleConnector.instance.getUserConversations(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserConversationsData, GetUserConversationsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getUserConversations(
  userId: userId,
);
GetUserConversationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = ExampleConnector.instance.getUserConversations(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetConversationMessages
#### Required Arguments
```dart
String conversationId = ...;
ExampleConnector.instance.getConversationMessages(
  conversationId: conversationId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetConversationMessagesData, GetConversationMessagesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getConversationMessages(
  conversationId: conversationId,
);
GetConversationMessagesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String conversationId = ...;

final ref = ExampleConnector.instance.getConversationMessages(
  conversationId: conversationId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetUserNotifications
#### Required Arguments
```dart
String userId = ...;
ExampleConnector.instance.getUserNotifications(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserNotificationsData, GetUserNotificationsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getUserNotifications(
  userId: userId,
);
GetUserNotificationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = ExampleConnector.instance.getUserNotifications(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetPendingVerifications
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getPendingVerifications().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetPendingVerificationsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getPendingVerifications();
GetPendingVerificationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getPendingVerifications().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateUser
#### Required Arguments
```dart
String email = ...;
String fullName = ...;
ExampleConnector.instance.createUser(
  email: email,
  fullName: fullName,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateUser, we created `CreateUserBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateUserVariablesBuilder {
  ...
   CreateUserVariablesBuilder collegeOrFaculty(String? t) {
   _collegeOrFaculty.value = t;
   return this;
  }
  CreateUserVariablesBuilder batchYear(int? t) {
   _batchYear.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.createUser(
  email: email,
  fullName: fullName,
)
.collegeOrFaculty(collegeOrFaculty)
.batchYear(batchYear)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateUserData, CreateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createUser(
  email: email,
  fullName: fullName,
);
CreateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;
String fullName = ...;

final ref = ExampleConnector.instance.createUser(
  email: email,
  fullName: fullName,
).ref();
ref.execute();
```


### CreateVerificationSubmission
#### Required Arguments
```dart
String userId = ...;
VerificationDocType documentType = ...;
String documentUrl = ...;
ExampleConnector.instance.createVerificationSubmission(
  userId: userId,
  documentType: documentType,
  documentUrl: documentUrl,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateVerificationSubmissionData, CreateVerificationSubmissionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createVerificationSubmission(
  userId: userId,
  documentType: documentType,
  documentUrl: documentUrl,
);
CreateVerificationSubmissionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
VerificationDocType documentType = ...;
String documentUrl = ...;

final ref = ExampleConnector.instance.createVerificationSubmission(
  userId: userId,
  documentType: documentType,
  documentUrl: documentUrl,
).ref();
ref.execute();
```


### CreateListing
#### Required Arguments
```dart
String sellerId = ...;
String title = ...;
double price = ...;
UniformType uniformType = ...;
UniformSizeType size = ...;
UniformSetType setType = ...;
OwnerGenderType previousOwnerGender = ...;
bool hasAssignedNumber = ...;
ItemConditionType condition = ...;
ExampleConnector.instance.createListing(
  sellerId: sellerId,
  title: title,
  price: price,
  uniformType: uniformType,
  size: size,
  setType: setType,
  previousOwnerGender: previousOwnerGender,
  hasAssignedNumber: hasAssignedNumber,
  condition: condition,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateListing, we created `CreateListingBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateListingVariablesBuilder {
  ...
   CreateListingVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.createListing(
  sellerId: sellerId,
  title: title,
  price: price,
  uniformType: uniformType,
  size: size,
  setType: setType,
  previousOwnerGender: previousOwnerGender,
  hasAssignedNumber: hasAssignedNumber,
  condition: condition,
)
.description(description)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateListingData, CreateListingVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createListing(
  sellerId: sellerId,
  title: title,
  price: price,
  uniformType: uniformType,
  size: size,
  setType: setType,
  previousOwnerGender: previousOwnerGender,
  hasAssignedNumber: hasAssignedNumber,
  condition: condition,
);
CreateListingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String sellerId = ...;
String title = ...;
double price = ...;
UniformType uniformType = ...;
UniformSizeType size = ...;
UniformSetType setType = ...;
OwnerGenderType previousOwnerGender = ...;
bool hasAssignedNumber = ...;
ItemConditionType condition = ...;

final ref = ExampleConnector.instance.createListing(
  sellerId: sellerId,
  title: title,
  price: price,
  uniformType: uniformType,
  size: size,
  setType: setType,
  previousOwnerGender: previousOwnerGender,
  hasAssignedNumber: hasAssignedNumber,
  condition: condition,
).ref();
ref.execute();
```


### CreateListingImage
#### Required Arguments
```dart
String listingId = ...;
String imageUrl = ...;
bool isPrimary = ...;
int displayOrder = ...;
ExampleConnector.instance.createListingImage(
  listingId: listingId,
  imageUrl: imageUrl,
  isPrimary: isPrimary,
  displayOrder: displayOrder,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateListingImageData, CreateListingImageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createListingImage(
  listingId: listingId,
  imageUrl: imageUrl,
  isPrimary: isPrimary,
  displayOrder: displayOrder,
);
CreateListingImageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String listingId = ...;
String imageUrl = ...;
bool isPrimary = ...;
int displayOrder = ...;

final ref = ExampleConnector.instance.createListingImage(
  listingId: listingId,
  imageUrl: imageUrl,
  isPrimary: isPrimary,
  displayOrder: displayOrder,
).ref();
ref.execute();
```


### UpdateListing
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateListing(
  id: id,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateListing, we created `UpdateListingBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateListingVariablesBuilder {
  ...
   UpdateListingVariablesBuilder title(String? t) {
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

  ...
}
ExampleConnector.instance.updateListing(
  id: id,
)
.title(title)
.description(description)
.price(price)
.uniformType(uniformType)
.size(size)
.setType(setType)
.previousOwnerGender(previousOwnerGender)
.hasAssignedNumber(hasAssignedNumber)
.condition(condition)
.status(status)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateListingData, UpdateListingVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateListing(
  id: id,
);
UpdateListingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateListing(
  id: id,
).ref();
ref.execute();
```


### CreateListingHistory
#### Required Arguments
```dart
String listingId = ...;
String changedById = ...;
String fieldName = ...;
ExampleConnector.instance.createListingHistory(
  listingId: listingId,
  changedById: changedById,
  fieldName: fieldName,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateListingHistory, we created `CreateListingHistoryBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateListingHistoryVariablesBuilder {
  ...
   CreateListingHistoryVariablesBuilder oldValue(String? t) {
   _oldValue.value = t;
   return this;
  }
  CreateListingHistoryVariablesBuilder newValue(String? t) {
   _newValue.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.createListingHistory(
  listingId: listingId,
  changedById: changedById,
  fieldName: fieldName,
)
.oldValue(oldValue)
.newValue(newValue)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateListingHistoryData, CreateListingHistoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createListingHistory(
  listingId: listingId,
  changedById: changedById,
  fieldName: fieldName,
);
CreateListingHistoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String listingId = ...;
String changedById = ...;
String fieldName = ...;

final ref = ExampleConnector.instance.createListingHistory(
  listingId: listingId,
  changedById: changedById,
  fieldName: fieldName,
).ref();
ref.execute();
```


### SoftDeleteListing
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.softDeleteListing(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<SoftDeleteListingData, SoftDeleteListingVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.softDeleteListing(
  id: id,
);
SoftDeleteListingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.softDeleteListing(
  id: id,
).ref();
ref.execute();
```


### CreateConversation
#### Required Arguments
```dart
String listingId = ...;
String buyerId = ...;
String sellerId = ...;
ExampleConnector.instance.createConversation(
  listingId: listingId,
  buyerId: buyerId,
  sellerId: sellerId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateConversationData, CreateConversationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createConversation(
  listingId: listingId,
  buyerId: buyerId,
  sellerId: sellerId,
);
CreateConversationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String listingId = ...;
String buyerId = ...;
String sellerId = ...;

final ref = ExampleConnector.instance.createConversation(
  listingId: listingId,
  buyerId: buyerId,
  sellerId: sellerId,
).ref();
ref.execute();
```


### SendMessage
#### Required Arguments
```dart
String conversationId = ...;
String senderId = ...;
String content = ...;
ExampleConnector.instance.sendMessage(
  conversationId: conversationId,
  senderId: senderId,
  content: content,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<SendMessageData, SendMessageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.sendMessage(
  conversationId: conversationId,
  senderId: senderId,
  content: content,
);
SendMessageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String conversationId = ...;
String senderId = ...;
String content = ...;

final ref = ExampleConnector.instance.sendMessage(
  conversationId: conversationId,
  senderId: senderId,
  content: content,
).ref();
ref.execute();
```


### UpdateConversationTimestamp
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateConversationTimestamp(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateConversationTimestampData, UpdateConversationTimestampVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateConversationTimestamp(
  id: id,
);
UpdateConversationTimestampData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateConversationTimestamp(
  id: id,
).ref();
ref.execute();
```


### MarkMessageRead
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.markMessageRead(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<MarkMessageReadData, MarkMessageReadVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.markMessageRead(
  id: id,
);
MarkMessageReadData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.markMessageRead(
  id: id,
).ref();
ref.execute();
```


### CreateNotification
#### Required Arguments
```dart
String userId = ...;
NotificationType type = ...;
String title = ...;
ExampleConnector.instance.createNotification(
  userId: userId,
  type: type,
  title: title,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateNotification, we created `CreateNotificationBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateNotificationVariablesBuilder {
  ...
   CreateNotificationVariablesBuilder body(String? t) {
   _body.value = t;
   return this;
  }
  CreateNotificationVariablesBuilder referenceId(String? t) {
   _referenceId.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.createNotification(
  userId: userId,
  type: type,
  title: title,
)
.body(body)
.referenceId(referenceId)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateNotificationData, CreateNotificationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createNotification(
  userId: userId,
  type: type,
  title: title,
);
CreateNotificationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
NotificationType type = ...;
String title = ...;

final ref = ExampleConnector.instance.createNotification(
  userId: userId,
  type: type,
  title: title,
).ref();
ref.execute();
```


### MarkNotificationRead
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.markNotificationRead(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<MarkNotificationReadData, MarkNotificationReadVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.markNotificationRead(
  id: id,
);
MarkNotificationReadData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.markNotificationRead(
  id: id,
).ref();
ref.execute();
```


### UpdateUserAvatar
#### Required Arguments
```dart
String id = ...;
String avatarUrl = ...;
ExampleConnector.instance.updateUserAvatar(
  id: id,
  avatarUrl: avatarUrl,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateUserAvatarData, UpdateUserAvatarVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateUserAvatar(
  id: id,
  avatarUrl: avatarUrl,
);
UpdateUserAvatarData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String avatarUrl = ...;

final ref = ExampleConnector.instance.updateUserAvatar(
  id: id,
  avatarUrl: avatarUrl,
).ref();
ref.execute();
```


### UpdateUserProfile
#### Required Arguments
```dart
String id = ...;
String fullName = ...;
ExampleConnector.instance.updateUserProfile(
  id: id,
  fullName: fullName,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateUserProfile, we created `UpdateUserProfileBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateUserProfileVariablesBuilder {
  ...
   UpdateUserProfileVariablesBuilder collegeOrFaculty(String? t) {
   _collegeOrFaculty.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateUserProfile(
  id: id,
  fullName: fullName,
)
.collegeOrFaculty(collegeOrFaculty)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateUserProfileData, UpdateUserProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateUserProfile(
  id: id,
  fullName: fullName,
);
UpdateUserProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String fullName = ...;

final ref = ExampleConnector.instance.updateUserProfile(
  id: id,
  fullName: fullName,
).ref();
ref.execute();
```


### ReviewVerificationSubmission
#### Required Arguments
```dart
String userId = ...;
String submissionId = ...;
VerificationStatus status = ...;
ExampleConnector.instance.reviewVerificationSubmission(
  userId: userId,
  submissionId: submissionId,
  status: status,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<ReviewVerificationSubmissionData, ReviewVerificationSubmissionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.reviewVerificationSubmission(
  userId: userId,
  submissionId: submissionId,
  status: status,
);
ReviewVerificationSubmissionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;
String submissionId = ...;
VerificationStatus status = ...;

final ref = ExampleConnector.instance.reviewVerificationSubmission(
  userId: userId,
  submissionId: submissionId,
  status: status,
).ref();
ref.execute();
```

