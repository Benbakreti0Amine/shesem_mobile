import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/get_user_model.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, UserState>(
      listener: (context, state) {
        // if (state is SignInFailure) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(state.errMessage),
        //       backgroundColor: Colors.red,
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            centerTitle: true,
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(UserState state) {
    if (state is GetprofileLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is GetProfilesuccess) {
      return _buildProfile(state.user);
    } else {
      return const Center(
        child: Text('No profile data available'),
      );
    }
  }

  Widget _buildProfile(GetUserModel user) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        
        // Profile Image Section
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 24),

        // User Information Cards
        Card(
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Username'),
            subtitle: Text(
              user.username,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 12),

        Card(
          child: ListTile(
            leading: const Icon(Icons.person_outline, color: Colors.blue),
            title: const Text('First Name'),
            subtitle: Text(
              user.first_name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 12),

        Card(
          child: ListTile(
            leading: const Icon(Icons.person_outline, color: Colors.blue),
            title: const Text('Last Name'),
            subtitle: Text(
              user.last_name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 12),

        Card(
          child: ListTile(
            leading: const Icon(Icons.verified_user, color: Colors.blue),
            title: const Text('Account Status'),
            subtitle: Text(
              user.is_active ? 'Active' : 'Inactive',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: user.is_active ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        Card(
          child: ListTile(
            leading: const Icon(Icons.numbers, color: Colors.blue),
            title: const Text('User ID'),
            subtitle: Text(
              '#${user.id}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
