import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSend;
  final Function(bool) onRecordingStateChange;
  final bool isRecording;

  const ChatInputField({
    Key? key,
    required this.onSend,
    required this.onRecordingStateChange,
    this.isRecording = false,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  
  bool _showKeyboard = false;
  bool _isHoldingMic = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateState);
    
    // Initialize animations
    _animController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_updateState);
    _controller.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSend(_controller.text.trim());
      _controller.clear();
    }
  }

  void _toggleKeyboard() {
    setState(() {
      _showKeyboard = !_showKeyboard;
    });
  }

  void _startRecording() {
    setState(() {
      _isHoldingMic = true;
    });
    _animController.forward();
    widget.onRecordingStateChange(true);
  }

  void _stopRecording() {
    setState(() {
      _isHoldingMic = false;
    });
    _animController.reverse();
    widget.onRecordingStateChange(false);
    // Here you would process the recording
  }

  void _showFeedback() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Give Feedback',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'How was your experience with Sara?',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Close',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF8273F0),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8273F0),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      // Remove any gaps by extending to the bottom edge
      child: SafeArea(
        top: false,
        bottom: true, // Ensures we respect the safe area at the bottom
        minimum: EdgeInsets.zero, // No minimum padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text input field (visible only when keyboard is active)
            if (_showKeyboard)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              _handleSend();
                            }
                          },
                        ),
                      ),
                      if (_controller.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xFF8273F0),
                          ),
                          onPressed: _handleSend,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ),
              ),
            
            // Button row with centered voice button
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Keyboard toggle button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: _toggleKeyboard,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _showKeyboard
                              ? const Color(0xFF8273F0).withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Icon(
                          Icons.keyboard,
                          color: _showKeyboard
                              ? const Color(0xFF8273F0)
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  
                  // Voice button (larger and centered)
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: GestureDetector(
                      onLongPressStart: (_) => _startRecording(),
                      onLongPressEnd: (_) => _stopRecording(),
                      onLongPressCancel: () => _stopRecording(),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: _isHoldingMic
                                ? [const Color(0xFFC861FF), const Color(0xFF8273F0)]
                                : [const Color(0xFF8273F0), const Color(0xFFC861FF)],
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8273F0).withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _isHoldingMic ? Icons.mic : Icons.mic_none,
                                color: Colors.white,
                                size: 28,
                              ),
                              if (!_isHoldingMic)
                                const Text(
                                  "Hold",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Feedback button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: _showFeedback,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Recording indicator (visible only when recording)
            if (_isHoldingMic)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8273F0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.graphic_eq,
                        color: Color(0xFF8273F0),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Recording... Release to send",
                        style: TextStyle(
                          color: Color(0xFF8273F0),
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}