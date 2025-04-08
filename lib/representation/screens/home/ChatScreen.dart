import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String profileImage;

  const ChatScreen({
    Key? key,
    required this.name,
    required this.profileImage,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Liste des messages
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'السلام عليكم، كيف حالك؟ عندي سؤال حول سقي المحاصيل. الأوراق قاعدة تصفر، عندكم فكرة على السبب؟',
      'isMe': true,
      'time': '09:10',
    },
    {
      'text': 'وعليكم السلام، يمكن يكون بسبب الجفاف أو السقي الزائد. كيف تسقي عادة؟',
      'isMe': false,
      'time': '09:12',
    },
    {
      'text': 'نتسقفهم كل صباح والتربة تبقى رطبة',
      'isMe': true,
      'time': '09:15',
    },
    {
      'text': 'السقي الزائد يسبب تعفن الجذور. جرب تسقي مرة وحدة في اليوم وخلي التربة تنشف شوية',
      'isMe': false,
      'time': '09:18',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 30,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(widget.profileImage),
            ),
            SizedBox(width: 10),
            Text(
              widget.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: Colors.black),
            onPressed: () {},
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // Fond dégradé vert clair
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFE8F5E9),
            ],
          ),
        ),
        child: Column(
          children: [
            // Liste des messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message['isMe'] as bool;
                  
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 16,
                        left: isMe ? 50 : 0,
                        right: isMe ? 0 : 50,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isMe ? Color(0xFF44AA00) : Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 4),
                          Text(
                            message['time'],
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Zone de saisie de message
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  // Bouton d'envoi
                  CircleAvatar(
                    backgroundColor: Color(0xFF44AA00),
                    radius: 20,
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          setState(() {
                            messages.add({
                              'text': _messageController.text,
                              'isMe': true,
                              'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                            });
                            _messageController.clear();
                          });
                          
                          // Scroll vers le bas pour voir le nouveau message
                          Future.delayed(Duration(milliseconds: 100), () {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  
                  // Bouton pour les pièces jointes
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: () {},
                  ),
                  
                  // Champ de saisie
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: '...قم بكتابة رسالة',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
