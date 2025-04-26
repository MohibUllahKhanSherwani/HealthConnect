import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsultationChatScreen extends StatefulWidget {
  const ConsultationChatScreen({super.key});

  @override
  _ConsultationChatScreenState createState() => _ConsultationChatScreenState();
}

class _ConsultationChatScreenState extends State<ConsultationChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello, how can I help you today?',
      'isDoctor': true,
      'time': '10:00 AM'
    },
    {
      'text': 'I have been experiencing headaches for the past few days.',
      'isDoctor': false,
      'time': '10:01 AM'
    },
    {
      'text': 'How severe are the headaches on a scale of 1-10?',
      'isDoctor': true,
      'time': '10:02 AM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Dr. Alice Smith'),
          backgroundColor: Colors.deepPurpleAccent,
          actions: [
            IconButton(
              icon: const Icon(Icons.video_call),
              onPressed: () {
                // TODO: Implement video call
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Video call feature coming soon!'),
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
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message['isDoctor']
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message['isDoctor']
                            ? Colors.grey.shade200
                            : Colors.deepPurpleAccent.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                              fontSize: 16,
                              color: message['isDoctor']
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message['time'],
                            style: TextStyle(
                              fontSize: 12,
                              color: message['isDoctor']
                                  ? Colors.black54
                                  : Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      // TODO: Implement file attachment
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('File attachment coming soon!'),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          setState(() {
                            _messages.add({
                              'text': _messageController.text,
                              'isDoctor': false,
                              'time':
                                  '${DateTime.now().hour}:${DateTime.now().minute}'
                            });
                            _messageController.clear();
                          });

                          // Simulate doctor response after a delay
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              _messages.add({
                                'text':
                                    'Thank you for sharing that information. I\'ll need to know more about your symptoms.',
                                'isDoctor': true,
                                'time':
                                    '${DateTime.now().hour}:${DateTime.now().minute}'
                              });
                            });
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
