import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pathfitfinder/controllers/chat_controller.dart';
import 'package:pathfitfinder/controllers/marketplace_controller.dart';
import 'package:pathfitfinder/main.dart';
import 'package:pathfitfinder/models/listing.dart';
import 'package:pathfitfinder/screens/auth_screen.dart';
import 'package:pathfitfinder/screens/chat_screen.dart';
import 'package:pathfitfinder/screens/filter_sheet.dart';
import 'package:pathfitfinder/screens/listing_details_screen.dart';
import 'package:pathfitfinder/screens/marketplace_screen.dart';
import 'package:pathfitfinder/screens/profile_screen.dart';
import 'package:pathfitfinder/screens/sell_screen.dart';
import 'package:pathfitfinder/services/media_service.dart';
import 'package:pathfitfinder/theme.dart';

class SampleMediaService extends MediaService {
  @override
  Future<XFile?> pick({bool camera = false}) async =>
      XFile('assets/figma/8b601.png');
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> capture(WidgetTester tester, String name) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(const Key('capture')),
  );
  final image = await boundary.toImage(pixelRatio: 1);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  final directory = Directory('build/visual_checks')
    ..createSync(recursive: true);
  File('${directory.path}/$name.png')
      .writeAsBytesSync(data!.buffer.asUint8List());
  image.dispose();
}

Widget app(Widget home) => MaterialApp(
  theme: buildTheme(),
  home: RepaintBoundary(key: const Key('capture'), child: home),
);

Future<void> openEditor(
  WidgetTester tester,
  MarketplaceController market, {
  Listing? existing,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      key: UniqueKey(),
      theme: buildTheme(),
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => SellScreen(market: market, existing: existing),
              ),
            ),
            child: const Text('Open editor'),
          ),
        ),
      ),
    ),
  );
  await tapVisible(tester, find.text('Open editor'));
}

void main() {
  setUpAll(() async {
    final loader = FontLoader('Inter')
      ..addFont(rootBundle.load('assets/fonts/InterVariable.ttf'));
    await loader.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  testWidgets('registration validates and login/signup navigation works', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tapVisible(tester, find.text('Create my account'));
    expect(find.text('Enter a username.'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('username')), 'bad user');
    await tapVisible(tester, find.text('Create my account'));
    expect(
      find.text('Use 3–20 letters, numbers, underscores, or periods.'),
      findsOneWidget,
    );
    await tapVisible(tester, find.text('Already in the circle? Log in'));
    expect(find.text('Welcome back.\nYour circle awaits.'), findsOneWidget);
    expect(find.byKey(const Key('username')), findsNothing);
    expect(find.text('Upload image'), findsNothing);
    await tapVisible(tester, find.byTooltip('Show password'));
    expect(
      tester
          .widget<TextField>(
            find.descendant(
              of: find.byKey(const Key('password')),
              matching: find.byType(TextField),
            ),
          )
          .obscureText,
      isFalse,
    );
    await tester.enterText(
      find.byKey(const Key('email')),
      'student@cics.ust.edu.ph',
    );
    await tester.enterText(find.byKey(const Key('password')), 'password1');
    await tapVisible(tester, find.text('Log in'));
    expect(find.byKey(const Key('auth-error')), findsOneWidget);
    expect(find.byType(MarketplaceScreen), findsNothing);
    await tapVisible(tester, find.text('Don’t have an account? Sign up'));
    expect(find.byKey(const Key('username')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('registration document selection and honest backend error', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(402, 940);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      app(AuthScreen(mediaService: SampleMediaService())),
    );
    await tester.enterText(find.byKey(const Key('username')), 'student_1');
    await tester.enterText(
      find.byKey(const Key('email')),
      'student@ust.edu.ph',
    );
    await tester.enterText(find.byKey(const Key('password')), 'password1');
    await tapVisible(tester, find.text('Upload image'));
    expect(find.byTooltip('Remove document'), findsOneWidget);
    await tapVisible(tester, find.text('Create my account'));
    expect(find.byKey(const Key('auth-error')), findsOneWidget);
    expect(find.byType(MarketplaceScreen), findsNothing);
    expect(
      tester
          .widget<TextFormField>(find.byKey(const Key('password')))
          .controller!
          .text,
      isEmpty,
    );
  });
  testWidgets(
    'marketplace search, saved, filter, details, chat and navigation',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(app(const MarketplaceScreen()));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('search')), 'volleyball');
      await tester.pumpAndSettle();
      expect(find.text('Volleyball set'), findsOneWidget);
      expect(find.text('Fitness training shirt'), findsNothing);
      await tapVisible(tester, find.byTooltip('Save uniform').first);
      await tester.tap(find.byKey(const Key('nav-Saved')));
      await tester.pumpAndSettle();
      expect(find.text('Volleyball set'), findsOneWidget);
      await tapVisible(tester, find.text('Volleyball set'));
      expect(find.byType(ListingDetailsScreen), findsOneWidget);
      await tapVisible(tester, find.text('Message seller'));
      expect(find.byType(ChatScreen), findsOneWidget);
      await tester.enterText(
        find.byKey(const Key('message')),
        'Is this available?',
      );
      await tester.tap(find.byTooltip('Send preview message'));
      await tester.pumpAndSettle();
      expect(find.text('Is this available?'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nav-Browse')));
      await tester.pumpAndSettle();
      await tapVisible(tester, find.byTooltip('Open filters'));
      expect(find.byType(FilterSheet), findsOneWidget);
      await tapVisible(tester, find.text('Low to high'));
      await tapVisible(tester, find.text('Show 1 uniforms'));
      expect(find.byType(FilterSheet), findsNothing);
      await tester.tap(find.byKey(const Key('nav-Inbox')));
      await tester.pumpAndSettle();
      expect(find.text('Campus conversations'), findsOneWidget);
      await tester.tap(find.byKey(const Key('nav-Profile')));
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);
      await tester.tap(find.byKey(const Key('nav-Sell')));
      await tester.pumpAndSettle();
      expect(find.byType(SellScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('sell draft, publish, edit and delete preview listing', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(402, 940);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final market = MarketplaceController();
    addTearDown(market.dispose);
    await openEditor(tester, market);
    await tapVisible(
      tester,
      find.text('Use sample uniform photos for preview'),
    );
    await tester.enterText(find.byKey(const Key('listing-price')), '250');
    await tester.enterText(
      find.byKey(const Key('listing-description')),
      'Clean uniform, used for a semester.',
    );
    await tapVisible(tester, find.text('Save draft'));
    expect(market.draft!.price, 250);
    await tapVisible(tester, find.text('Publish preview listing'));
    expect(market.all.first.price, 250);
    final listing = market.all.first;
    await openEditor(tester, market, existing: listing);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('listing-price')), '200');
    await tapVisible(tester, find.text('Save Changes'));
    expect(market.find(listing.id)!.price, 200);
    await openEditor(tester, market, existing: market.find(listing.id));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Delete Listing'));
    await tapVisible(tester, find.text('Keep listing'));
    expect(market.find(listing.id), isNotNull);
    await tapVisible(tester, find.text('Delete Listing'));
    await tapVisible(tester, find.text('Delete Listing').last);
    expect(market.find(listing.id), isNull);
    expect(tester.takeException(), isNull);
  });
  for (final size in [
    const Size(320, 568),
    const Size(360, 800),
    const Size(390, 844),
    const Size(402, 940),
  ]) {
    testWidgets(
      'screen layouts fit ${size.width.toInt()} × ${size.height.toInt()}',
      (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final market = MarketplaceController();
        final chat = ChatController();
        addTearDown(market.dispose);
        addTearDown(chat.dispose);
        final screens = <String, Widget>{
          'registration': const AuthScreen(),
          'login': const AuthScreen(login: true),
          'browse': const MarketplaceScreen(),
          'details': ListingDetailsScreen(
            id: 'basketball',
            market: market,
            chat: chat,
          ),
          'sell': SellScreen(
            market: market,
            existing: market.find('basketball'),
          ),
          'chat': ChatScreen(
            listing: market.find('basketball')!,
            controller: chat,
          ),
          'profile': Scaffold(
            body: SafeArea(
              child: ProfileScreen(market: market, chat: chat),
            ),
          ),
          'filters': Scaffold(body: FilterSheet(controller: market)),
        };
        for (final entry in screens.entries) {
          await tester.pumpWidget(app(entry.value));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: entry.key);
          for (final text in [
            'Exclusively for UST students & alumni',
            'Meet up at UST · España gate',
            'Keep it on campus. Check the uniform in person before paying.',
            'Honest details make a better campus marketplace.',
          ]) {
            expect(find.text(text), findsNothing, reason: entry.key);
          }
          if (size.width == 402) {
            await tester.runAsync(() => capture(tester, entry.key));
          }
          await tester.pumpWidget(const SizedBox());
          await tester.pumpAndSettle();
        }
      },
    );
  }
}
