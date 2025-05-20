import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../chat/models/chat_message.dart';

class AiMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onPlayTap;
  final VoidCallback? onPauseTap;
  final bool isPlaying;

  const AiMessageBubble({
    Key? key,
    required this.message,
    this.onPlayTap,
    this.onPauseTap,
    this.isPlaying = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF8273F0), // AI message bubble color
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
              if (message.hasVoice) const SizedBox(height: 8),
              if (message.hasVoice)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Play/Pause button
                    InkWell(
                      onTap: isPlaying ? onPauseTap : onPlayTap,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: const Color(0xFF8273F0),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Audio wave visualization (simplified)
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.graphic_eq,
                          color: const Color(0xFF8273F0),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}