import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/report_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/user_report_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Chat Screen'), 
      ),);
  }
}
  