import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pathfitfinder/controllers/auth_controller.dart';
import 'package:pathfitfinder/controllers/chat_controller.dart';
import 'package:pathfitfinder/controllers/listing_editor_controller.dart';
import 'package:pathfitfinder/controllers/marketplace_controller.dart';
import 'package:pathfitfinder/models/auth_models.dart';
import 'package:pathfitfinder/models/listing.dart';
import 'package:pathfitfinder/services/auth_service.dart';

class PendingAuthService implements AuthService {
  final completer = Completer<void>();
  RegistrationRequest? request;
  @override
  Future<void> register(RegistrationRequest request) {
    this.request = request;
    return completer.future;
  }

  @override
  Future<void> login({required String email, required String password}) =>
      completer.future;
}

void main() {
  test('username boundaries and allowed characters', () {
    for (final name in ['', 'ab', 'a b', 'name!', 'a' * 21, ' name']) {
      expect(AuthValidators.username(name), isNotNull, reason: name);
    }
    for (final name in ['abc', 'user.name_12', 'a' * 20]) {
      expect(AuthValidators.username(name), isNull, reason: name);
    }
  });
  test('UST email accepts student subdomains and rejects lookalikes', () {
    for (final email in ['student@ust.edu.ph', 'student@cics.ust.edu.ph']) {
      expect(AuthValidators.email(email), isNull);
    }
    for (final email in [
      'student@gmail.com',
      'student@fakeust.edu.ph',
      'a@ust.edu.ph.evil',
      'a@@ust.edu.ph',
    ]) {
      expect(AuthValidators.email(email), isNotNull);
    }
    expect(AuthValidators.password('1234567'), isNotNull);
    expect(AuthValidators.password('12345678'), isNull);
    expect(AuthValidators.password('', registration: false), isNotNull);
  });
  test(
    'auth has loading/error states and carries username into service request',
    () async {
      final service = PendingAuthService();
      final auth = AuthController(service: service);
      final future = auth.submit(
        registration: true,
        email: 'a@ust.edu.ph',
        password: 'password1',
        username: 'student_1',
        verificationPath: 'id.png',
      );
      expect(auth.loading, isTrue);
      expect(service.request!.username, 'student_1');
      service.completer.completeError(const AuthUnavailable());
      await future;
      expect(auth.loading, isFalse);
      expect(auth.error, contains('not connected'));
      auth.dispose();
    },
  );
  test('default login never claims success', () async {
    final auth = AuthController();
    await auth.submit(
      registration: false,
      email: 'a@ust.edu.ph',
      password: 'password1',
    );
    expect(auth.error, contains('not been signed in'));
    auth.dispose();
  });
  test('marketplace filters, sorting, saved items and sold state', () {
    final market = MarketplaceController();
    expect(market.results().length, 4);
    market.applyFilter(
      const ListingFilter(
        sport: 'Basketball',
        size: 'M',
        number: 'With number',
        sort: 'Low to high',
      ),
    );
    expect(market.results().map((l) => l.price), [150, 350]);
    market.applyFilter(
      const ListingFilter(
        wornBy: 'Female',
        condition: 'Good',
        included: 'Complete set',
      ),
    );
    expect(market.results().single.id, 'volleyball');
    market.search('missing');
    expect(market.results(), isEmpty);
    market.search('');
    market.toggleSaved('basketball');
    expect(market.saved.single.id, 'basketball');
    market.markSold('basketball');
    expect(market.saved, isEmpty);
    expect(market.find('basketball')!.sold, isTrue);
    market.delete('volleyball');
    expect(market.find('volleyball'), isNull);
    market.dispose();
  });
  test('draft, publishing and editing preserve listing identity', () {
    final editor = ListingEditorController();
    expect(editor.validatePhotos(), isFalse);
    editor.addSamplePhotos();
    editor.price = '250';
    editor.description = 'Used for one term.';
    final market = MarketplaceController();
    final draft = editor.buildListing();
    market.saveDraft(draft);
    final restored = ListingEditorController(initial: market.draft);
    expect(restored.images.length, 2);
    expect(restored.price, '250');
    market.save(restored.buildListing());
    expect(market.draft, isNull);
    market.save(draft.copyWith(price: 200));
    expect(market.find(draft.id)!.price, 200);
    expect(market.all.where((l) => l.id == draft.id).length, 1);
    editor.dispose();
    restored.dispose();
    market.dispose();
  });
  test('messages stay isolated by listing and blank messages are ignored', () {
    final chat = ChatController();
    chat.send('volleyball', 'Hello!');
    chat.send('volleyball', '  ');
    expect(chat.messages('volleyball').single.text, 'Hello!');
    expect(chat.messages('basketball').length, 4);
    chat.dispose();
  });
  test('editing price preserves a specific listing title and sold status', () {
    final market = MarketplaceController();
    final original = market.find('sold-shirt')!;
    final editor = ListingEditorController(initial: original);
    editor.price = '160';
    final edited = editor.buildListing();
    expect(edited.title, original.title);
    expect(edited.sold, isTrue);
    expect(edited.price, 160);
    editor.dispose();
    market.dispose();
  });
}
