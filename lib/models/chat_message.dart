class ChatMessage {
  const ChatMessage(this.text, {this.mine = false, this.imagePath});
  final String text;
  final bool mine;
  final String? imagePath;
}
