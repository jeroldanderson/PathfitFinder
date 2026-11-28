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
  void initState() {
    super.initState();
    widget.controller.openThread(widget.listing.id);
  }

  @override
  void dispose() {
    widget.controller.closeThread();
    _text.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (widget.listing.deleted) return;
    final content = _text.text.trim();
    if (content.isEmpty) return;
    _text.clear();
    try {
      await widget.controller.send(widget.listing.id, content);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scroll.hasClients) {
          _scroll.animateTo(
            _scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (_) {
      if (mounted) {
        showNotice(context, 'Could not send message. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.controller,
    builder: (context, _) {
      final messages = widget.controller.messages(widget.listing.id);
      final peerName = widget.controller.otherPartyName(widget.listing.id);
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: cream,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  peerName.trim().isNotEmpty
                      ? peerName.trim()[0].toUpperCase()
                      : 'T',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ink,
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            peerName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const DesignIcon('8a371.svg', size: 15),
                      ],
                    ),
                    const Text(
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
                'Keep meetups inside UST campus and inspect the uniform before paying.',
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
                            Text(
                              widget.listing.deleted
                                  ? 'Deleted'
                                  : widget.listing.sold
                                      ? 'Sold'
                                      : 'Available',
                              style: TextStyle(
                                fontSize: 10,
                                color: widget.listing.deleted
                                    ? Colors.red.shade700
                                    : muted,
                                fontWeight: widget.listing.deleted
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
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
                        'KEEP IT ON CAMPUS · CHECK BEFORE PAYING',
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
                            margin: const EdgeInsets.only(bottom: 18),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: message.mine ? cream : surface,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: message.mine
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                if (message.imagePath == null)
                                  Text(message.text)
                                else
                                  Photo(
                                    message.imagePath!,
                                    width: 200,
                                    height: 180,
                                  ),
                                if (message.mine && message.isRead) ...[
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Read',
                                    style: TextStyle(fontSize: 9, color: muted),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.listing.deleted)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: surface,
                    border: Border(top: BorderSide(color: line)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, size: 18, color: muted),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'This listing was deleted by the seller. You can no longer send messages in this thread.',
                          style: TextStyle(fontSize: 12, color: muted),
                        ),
                      ),
                    ],
                  ),
                )
              else ...[
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
                          onPressed: () => _text.text = widget.listing.owned
                              ? 'Hello, are you interested?'
                              : 'Is this uniform still available?',
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
                        tooltip: 'Attach photo',
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
                            hintText: 'Message $peerName…',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filled(
                        tooltip: 'Send message',
                        onPressed: _send,
                        style: IconButton.styleFrom(backgroundColor: yellow),
                        icon: const DesignIcon('89521.svg'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}
