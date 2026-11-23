# Basic Usage

```dart
ExampleConnector.instance.CreateUser(createUserVariables).execute();
ExampleConnector.instance.CreateVerificationSubmission(createVerificationSubmissionVariables).execute();
ExampleConnector.instance.CreateListing(createListingVariables).execute();
ExampleConnector.instance.CreateListingImage(createListingImageVariables).execute();
ExampleConnector.instance.UpdateListing(updateListingVariables).execute();
ExampleConnector.instance.CreateListingHistory(createListingHistoryVariables).execute();
ExampleConnector.instance.SoftDeleteListing(softDeleteListingVariables).execute();
ExampleConnector.instance.CreateConversation(createConversationVariables).execute();
ExampleConnector.instance.SendMessage(sendMessageVariables).execute();
ExampleConnector.instance.UpdateConversationTimestamp(updateConversationTimestampVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ExampleConnector.instance.UpdateUserProfile({ ... })
.collegeOrFaculty(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

