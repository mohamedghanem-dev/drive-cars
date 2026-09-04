class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final String timestamp;
  final bool isMe;
  final int? offerAmount;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.offerAmount,
  });
}

class Conversation {
  final String id;
  final String participantId;
  final String participantName;
  final String participantAvatar;
  final String participantRole;
  String lastMessage;
  String lastMessageTime;
  int unreadCount;
  final String? carId;
  final String? carTitle;
  final int? carPrice;
  final String? carImage;
  final List<ChatMessage> messages;

  Conversation({
    required this.id,
    required this.participantId,
    required this.participantName,
    required this.participantAvatar,
    required this.participantRole,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.carId,
    this.carTitle,
    this.carPrice,
    this.carImage,
    required this.messages,
  });
}
