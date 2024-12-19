import 'package:deep_scan_app/blocs/user/user_bloc.dart';
import 'package:deep_scan_app/blocs/user/user_event.dart';
import 'package:deep_scan_app/blocs/user/user_state.dart';
import 'package:deep_scan_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  final UserRepository userRepository;

  const UserScreen({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: BlocProvider(
        create: (_) => UserBloc(userRepository)..add(FetchUsers()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {

                  final user = state.users[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(user.name![0]),
                      ),
                      title: Text(user.name!),
                      subtitle: Text(user.originalName!),
                    ),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load users.',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<UserBloc>().add(FetchUsers()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
