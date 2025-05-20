import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_message.dart';
import '../widgets/ai_message_bubble.dart';
import '../widgets/user_message_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/lesson_progress_bar.dart';

class LessonChatScreen extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  const LessonChatScreen({
    Key? key,
    required this.lessonId,
    this.lessonTitle = 'First lesson',
  }) : super(key: key);

  @override
  State<LessonChatScreen> createState() => _LessonChatScreenState();
}

class _LessonChatScreenState extends State<LessonChatScreen> {
  late ChatController _chatController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    // Initialize the chat controller with initial AI message
    _chatController = ChatController(
      initialLesson: Lesson(
        id: widget.lessonId,
        title: widget.lessonTitle,
        messages: [
          ChatMessage(
            text: "Hey Hisham! I'm Sara, your personal AI English tutor. So, what brings you here? Why do you want to improve your English?",
            type: MessageType.ai,
            timestamp: DateTime.now(),
            hasVoice: true,
          ),
        ],
      ),
    );
    
    // Listen for changes to scroll to bottom when new messages arrive
    _chatController.addListener(_scrollToBottom);
  }

  @override
  void dispose() {
    _chatController.removeListener(_scrollToBottom);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _chatController,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EAFF),
        body: Column(
          children: [
            // SafeArea for the top section
            SafeArea(
              bottom: false, // No safe area at bottom for the messages
              child: Consumer<ChatController>(
                builder: (context, controller, _) {
                  return LessonProgressBar(
                    progress: controller.currentLesson.progress,
                    title: controller.currentLesson.title,
                  );
                },
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Chat messages
            Expanded(
              child: Consumer<ChatController>(
                builder: (context, controller, _) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      
                      if (message.isAi) {
                        return AiMessageBubble(
                          message: message,
                          isPlaying: controller.isPlaying,
                          onPlayTap: () => controller.togglePlaying(),
                          onPauseTap: () => controller.togglePlaying(),
                        );
                      } else {
                        return UserMessageBubble(
                          message: message,
                        );
                      }
                    },
                  );
                },
              ),
            ),
            
            // Chat input field with enhanced UI - no SafeArea here
            Consumer<ChatController>(
              builder: (context, controller, _) {
                return ChatInputField(
                  isRecording: controller.isRecording,
                  onRecordingStateChange: (isRecording) => 
                      controller.setRecordingState(isRecording),
                  onSend: (text) => controller.addUserMessage(text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}