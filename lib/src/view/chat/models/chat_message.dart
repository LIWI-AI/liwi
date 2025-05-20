import 'package:flutter/material.dart';

enum MessageType {
  ai,
  user,
}

class ChatMessage {
  final String text;
  final MessageType type;
  final DateTime timestamp;
  final bool hasVoice;

  ChatMessage({
    required this.text,
    required this.type,
    required this.timestamp,
    this.hasVoice = false,
  });

  bool get isAi => type == MessageType.ai;
  bool get isUser => type == MessageType.user;
}

class Lesson {
  final String id;
  final String title;
  final double progress;
  final List<ChatMessage> messages;

  Lesson({
    required this.id,
    required this.title,
    this.progress = 0.0,
    this.messages = const [],
  });

  Lesson copyWith({
    String? id,
    String? title,
    double? progress,
    List<ChatMessage>? messages,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
      messages: messages ?? this.messages,
    );
  }

  Lesson addMessage(ChatMessage message) {
    List<ChatMessage> updatedMessages = List.from(messages)..add(message);
    return copyWith(messages: updatedMessages);
  }

  /// Calculate progress based on conversation milestones
  Lesson updateProgress() {
    // This is a simplified logic - in reality, you might have more complex
    // progress tracking logic based on lesson goals
    double newProgress = (messages.length / 10).clamp(0.0, 1.0);
    return copyWith(progress: newProgress);
  }
}