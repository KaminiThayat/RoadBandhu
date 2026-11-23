import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'mechanic_voice_call_screen.dart';

class InAppChatScreen extends StatefulWidget {
  const InAppChatScreen({super.key});

  @override
  State<InAppChatScreen> createState() => _InAppChatScreenState();
}

class _InAppChatScreenState extends State<InAppChatScreen> {
  final _messageController = TextEditingController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      sender: 'Rajesh Kumar',
      text: "नमस्ते! मैं राजेश, आपका असाइन किया गया मैकेनिक हूँ। Hello! I'm Rajesh, your assigned mechanic.",
      time: '9:42 AM',
      isMe: false,
    ),
    _ChatMessage(
      sender: 'You',
      text: 'मेरी गाड़ी स्टार्ट नहीं हो रही है। Engine is making clicking sound.',
      time: '9:43 AM',
      isMe: true,
    ),
    _ChatMessage(
      sender: 'You',
      text: '[Dashboard Battery Warning Light Attached]',
      time: '9:43 AM',
      isMe: true,
      hasAttachment: true,
    ),
    _ChatMessage(
      sender: 'Rajesh Kumar',
      text: 'ठीक है, बैटरी डाउन लग रही है। मैं जंप स्टार्टर किट लेकर 18 मिनट में पहुँच रहा हूँ।',
      time: '9:44 AM',
      isMe: false,
    ),
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        _ChatMessage(
          sender: 'You',
          text: text,
          time: '9:45 AM',
          isMe: true,
        ),
      );
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mountainDark,
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rajesh Kumar',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Online • Assigned Unit',
                        style: TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MechanicVoiceCallScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
                return _ChatBubble(message: m);
              },
            ),
          ),

          // Message input bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: AppColors.mountainSlate),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined, color: AppColors.mountainSlate),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message... / संदेश लिखें...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String sender;
  final String text;
  final String time;
  final bool isMe;
  final bool hasAttachment;

  _ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
    this.hasAttachment = false,
  });
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isMe
              ? AppColors.primary
              : (isDark ? AppColors.darkSurface : const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isMe ? 16 : 0),
            bottomRight: Radius.circular(message.isMe ? 0 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.hasAttachment) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.battery_alert, color: Colors.amber, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Dashboard Warning Light Photo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Text(
              message.text,
              style: TextStyle(
                fontSize: 13,
                color: message.isMe
                    ? Colors.white
                    : (isDark ? Colors.white : AppColors.lightTextPrimary),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(
                fontSize: 10,
                color: message.isMe ? Colors.white70 : AppColors.mountainSlate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
