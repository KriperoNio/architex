import 'dart:async';
import 'package:architex/core/theme/dark.dart';
import 'package:architex/ui/screens/room_editor/room_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/widgets/AppNavBar.dart';
/* 
  - lib/
   - main.dart                // Главный файл, запуск приложения
   - core/
       - constants/           // Константы (цвета, стили, размеры и пр.)
       - utils/               // Утилиты и хелперы для обработки данных
       - theme/               // Темы для приложения
       - router/              // Навигация и роутинг
   - models/                  // Модели данных
   - services/                // Сервисы (API, взаимодействие с базой данных)
   - providers/               // Провайдеры (стейт-менеджмент)
   - ui/
       - screens/             // Экраны
           - home/            // Главный экран
           - designer/        // Дизайн и VR/AR экран
           - showroom/        // Экран с виртуальным шоурумом
           - profile/         // Профиль и настройки
       - widgets/             // Общие виджеты приложения
   - data/
       - repository/          // Репозитории для взаимодействия с данными
       - local/               // Локальное хранилище и базы данных
       - remote/              // Внешние API, если есть
*/

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top]);
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _cancelTimer();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: GestureDetector(
        onTap: _resetTimer,
        child: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent),
    );
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const AppNavBar.mainTheme(),
      body: const ScreenRoomEditor(),
    );
  }
}
