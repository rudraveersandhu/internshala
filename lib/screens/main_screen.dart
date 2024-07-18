
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshala/screens/screen2.dart';
import 'package:internshala/screens/screen3.dart';
import 'package:internshala/screens/screen4.dart';
import 'package:internshala/screens/screen5.dart';


import 'home_screen.dart';




class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    const Screen2(),
    const Screen3(),
    const Screen4(),
    const Screen5(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: [
            // Main content
            IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.blue,
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: _onTabTapped,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white54,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.paperplane), label: 'Bookmarks'),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.briefcase_fill), label: 'Books'),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.group), label: 'Books'),
                    BottomNavigationBarItem(icon: Stack(
                      children: [
                        Icon(CupertinoIcons.tv),
                        Positioned(
                          left: 0,
                            right: 0,
                            top: 0,
                            bottom: 2,
                            child: Icon(CupertinoIcons.play,size: 10,)),
                      ],
                    ), label: 'Settings'),
                  ],
                ),
              ),
            )

          ],
        )

    );
  }
}