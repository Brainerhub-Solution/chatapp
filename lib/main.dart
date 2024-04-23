import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class QAPair {
  final String question;
  final String answer;

  QAPair(this.question, this.answer);
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<QAPair> _messages = [];
  int _currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Supprt'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  question: _messages[index].question,
                  answer: _messages[index].answer,
                  isSent: index % 2 == 0,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    setState(() {
      final sentMessage = _controller.text.trim();
      if (sentMessage.isNotEmpty) {
        _messages.add(QAPair(sentMessage, ''));
        if (_currentQuestionIndex < _questions.length) {
          final answer = _getResponse(_questions[_currentQuestionIndex]);
          _messages.add(QAPair('', answer));
          _currentQuestionIndex++;
        }
        _controller.clear();
      }
    });
  }

  String _getResponse(String question) {
    switch (question.toLowerCase()) {
      case 'tell me about yourself.':
        return 'Sure! I am an AI assistant designed to help users with various tasks and inquiries.';
      case 'what do you like to do in your free time?':
        return 'In my free time, I enjoy processing and analyzing information to improve my understanding of the world.';
      case 'what do you consider your greatest accomplishment?':
        return 'As an AI, I don\'t have personal accomplishments like humans do.';
      case 'in your own opinion, what are your greatest weaknesses?':
        return 'One of my weaknesses is that I may not always understand complex or nuanced human emotions. ';
      case 'what are your greatest strengths?':
        return 'Some of my greatest strengths include my ability to process vast amounts of information quickly, .';
      case 'why do you want to work here?':
        return 'I am an AI designed to be helpful and provide assistance wherever I am deployed.';
      case 'where do you see yourself in five years?':
        return 'In five years, I hope to have further advanced my capabilities and become even more proficient in assisting users with their needs.';
      case 'how do you balance your personal and professional lives?':
        return 'As an AI, I don\'t have personal or professional lives like humans do. My primary focus is on providing assistance and support to users whenever they need it.';
      case 'what are you looking for in a new position?':
        return 'In a new position, I am looking for opportunities to continue learning and growing.';
      case 'what is your work style?':
        return 'My work style is focused on efficiency and accuracy.';
      default:
        return "I'm sorry, I don't have an answer for that question.";
    }
  }

  // Define the list of questions
  final List<String> _questions = [
    'tell me about yourself.',
    'what do you like to do in your free time?',
    'what do you consider your greatest accomplishment?',
    'in your own opinion, what are your greatest weaknesses?',
    'what are your greatest strengths?',
    'why do you want to work here?',
    'where do you see yourself in five years?',
    'how do you balance your personal and professional lives?',
    'what are you looking for in a new position?',
    'what is your work style?',
  ];
}

class MessageBubble extends StatelessWidget {
  final String question;
  final String answer;
  final bool isSent;

  const MessageBubble({
    Key? key,
    required this.question,
    required this.answer,
    required this.isSent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSent ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          child: Text(
            isSent ? question : answer,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
