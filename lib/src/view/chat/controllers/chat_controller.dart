import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatController extends ChangeNotifier {
  Lesson _currentLesson;
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isTyping = false;
  
  ChatController({
    required Lesson initialLesson,
  }) : _currentLesson = initialLesson;
  
  // Getters
  Lesson get currentLesson => _currentLesson;
  List<ChatMessage> get messages => _currentLesson.messages;
  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;
  bool get isTyping => _isTyping;
  
  // Add a user message
  void addUserMessage(String text) {
    final message = ChatMessage(
      text: text,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );
    
    _currentLesson = _currentLesson.addMessage(message);
    _updateProgress();
    notifyListeners();
    
    // Simulate AI response after a short delay
    _simulateAiResponse(text);
  }
  
  // Add a voice message from the user
  void addUserVoiceMessage() {
    // In a real app, this would process the recorded voice
    // Here we're simulating it with a text message about voice
    final message = ChatMessage(
      text: "Voice message sent",
      type: MessageType.user,
      timestamp: DateTime.now(),
      hasVoice: true,
    );
    
    _currentLesson = _currentLesson.addMessage(message);
    _updateProgress();
    notifyListeners();
    
    // Simulate AI response to voice message
    _simulateAiResponse("voice message");
  }
  
  // Add an AI message
  void addAiMessage(String text, {bool hasVoice = true}) {
    final message = ChatMessage(
      text: text,
      type: MessageType.ai,
      timestamp: DateTime.now(),
      hasVoice: hasVoice,
    );
    
    _currentLesson = _currentLesson.addMessage(message);
    _updateProgress();
    notifyListeners();
  }
  
  // Update lesson progress
  void _updateProgress() {
    _currentLesson = _currentLesson.updateProgress();
    notifyListeners();
  }
  
  // Set recording state
  void setRecordingState(bool isRecording) {
    _isRecording = isRecording;
    notifyListeners();
    
    // If recording is finished, simulate sending a voice message
    if (!isRecording && _isRecording) {
      addUserVoiceMessage();
    }
  }
  
  // Toggle play state
  void togglePlaying() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
  
  // Set typing state
  void setTyping(bool isTyping) {
    _isTyping = isTyping;
    notifyListeners();
  }
  
  // Simulate AI response (in a real app, this would be an API call)
  void _simulateAiResponse(String userMessage) {
    setTyping(true);
    
    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      String response = '';
      
      // Simple response logic based on user input
      if (userMessage.toLowerCase().contains('job')) {
        response = "That's a great reason! Many jobs require English skills these days. What kind of job are you hoping to get?";
      } else if (userMessage.toLowerCase().contains('hello') || 
                userMessage.toLowerCase().contains('hi')) {
        response = "Hello! I'm Sara, your AI English tutor. How can I help you improve your English today?";
      } else if (userMessage.toLowerCase().contains('voice')) {
        response = "I heard your voice message! You're doing well with your pronunciation. Let's continue practicing.";
      } else {
        response = "Thank you for sharing that. Let's work on improving your English skills together. What specific area would you like to focus on?";
      }
      
      addAiMessage(response);
      setTyping(false);
    });
  }
}