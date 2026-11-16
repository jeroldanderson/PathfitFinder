import 'package:flutter/material.dart';

import '../controllers/chat_controller.dart';
import '../models/listing.dart';
import '../theme.dart';
import '../widgets/shared.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.listing,
    required this.controller,
  });
  final Listing listing;
  final ChatController controller;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _text = TextEditingController();
  final _scroll = ScrollController();
  @override
  void dispose() {
    _text.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    if (_text.text.trim().isEmpty) return;
    widget.controller.send(widget.listing.id, _text.text);
    _text.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.controller,
    builder: (context, _) {
      final messages = widget.controller.messages(widget.listing.id);
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          title: const Row(
            children: [
              Photo(
                'assets/figma/b7f5c.png',
                width: 42,
                height: 42,
                radius: 21,
              ),
              SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Mika Reyes',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        DesignIcon('8a371.svg', size: 15),
                      ],
                    ),
                    Text(
                      'Verified Thomasian',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Conversation information',
              onPressed: () => showNotice(
                context,
                'Preview conversation. Messages are not delivered to another person.',
              ),
              icon: const DesignIcon('85f39.svg'),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      Photo(
                        widget.listing.images.first,
                        width: 62,
                        height: 61,
                        radius: 8,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.listing.title,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₱${widget.listing.price}   ·   ${widget.listing.size} · ${widget.listing.condition}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Text(
                              'Preview conversation',
                              style: TextStyle(fontSize: 10, color: muted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  controller: _scroll,
                  children: [
                    const Center(
                      child: Text(
                        'TODAY',
                        style: TextStyle(fontSize: 9, color: muted),
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (messages.isEmpty)
                      const Text(
                        'Start a conversation about this uniform.',
                        style: TextStyle(color: muted),
                      ),
                    ...messages.map(
                      (message) => Align(
                        alignment: message.mine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * .76,
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: message.mine ? cream : surface,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: message.imagePath == null
                                ? Text(message.text)
                                : Photo(
                                    message.imagePath!,
                                    width: 200,
                                    height: 180,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            _text.text = 'Can we meet at the España gate?',
                        child: const Text(
                          'Share meetup spot',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            _text.text = 'Is this uniform still available?',
                        child: const Text(
                          'Ask a question',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 24, 12),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Attach preview photo',
                      onPressed: widget.controller.picking
                          ? null
                          : () async {
                              final error = await widget.controller.attach(
                                widget.listing.id,
                              );
                              if (context.mounted && error != null) {
                                showNotice(context, error);
                              }
                            },
                      icon: const DesignIcon('b3ede.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        key: const Key('message'),
                        controller: _text,
                        minLines: 1,
                        maxLines: 4,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _send(),
                        decoration: InputDecoration(
                          hintText: 'Message Mika…',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filled(
                      tooltip: 'Send preview message',
                      onPressed: _send,
                      style: IconButton.styleFrom(backgroundColor: yellow),
                      icon: const DesignIcon('89521.svg'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
