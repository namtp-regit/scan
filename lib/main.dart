import 'package:deep_scan_app/api/user_api.dart';
import 'package:deep_scan_app/repository/user_repository.dart';
import 'package:deep_scan_app/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo mọi thứ được khởi tạo trước khi gọi API.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
  final userRepository = UserRepository(UserApi());
    return MaterialApp(
      title: 'BLoC API Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserScreen(userRepository: userRepository),
    );
  }
}