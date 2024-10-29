import 'dart:async';
import 'package:architex/core/theme/dark.dart';
import 'package:architex/ui/screens/room_editor/room_editor.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/widgets/AppNavBar.dart';

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
  bool _isTablet = false;
  bool _isSamsungDevice = false;
  bool _isButtonNavigation = true;

  @override
  void initState() {
    super.initState();
    _detectDevice();
  }

  Future<void> _detectDevice() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final isTabletDevice = MediaQuery.of(context).size.shortestSide >= 600;

    setState(() {
      _isTablet = isTabletDevice;
      _isSamsungDevice = androidInfo.manufacturer.toLowerCase() == "samsung";

      // Проверка типа навигации на основе Android SDK версии
      _isButtonNavigation =
          androidInfo.systemFeatures.contains("android.software.home_screen");
    });

    // Запускаем таймер после завершения инициализации
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      if (_isSamsungDevice && _isTablet && _isButtonNavigation) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
      }
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
      bottomNavigationBar: AppNavBar.mainTheme(
        height: (context.findAncestorStateOfType<_MyAppState>()?._isTablet ??
                    false) &&
                (context
                        .findAncestorStateOfType<_MyAppState>()
                        ?._isSamsungDevice ??
                    false) &&
                (context
                        .findAncestorStateOfType<_MyAppState>()
                        ?._isButtonNavigation ??
                    false)
            ? 160 // удвоенная высота NavBar
            : 80,
      ),
      body: const SafeArea(
        child: ScreenRoomEditor(),
      ),
    );
  }
}
