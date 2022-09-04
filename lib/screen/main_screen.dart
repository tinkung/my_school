import 'package:flutter/material.dart';
import 'package:my_school/screen/about_screen.dart';
import 'package:my_school/screen/contact_screen.dart';
import 'package:my_school/screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Map<String, dynamic>> _menu = [
    {
      "title": "ข่าวสาร",
      "icon": Icons.newspaper,
      "screen": HomeScreen(),
    },
    {
      "title": "ติดต่อเรา",
      "icon": Icons.phone,
      "screen": ContactScreen(),
    },
    {
      "title": "เกี่ยวกับเรา",
      "icon": Icons.info,
      "screen": AboutScreen(),
    },
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_menu[_currentIndex]['title']),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Tinnakorn Srithep'),
              accountEmail: Text('tanapat.srithep12345@gmail.com'),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage: Image.network(
                  'https://ih1.redbubble.net/image.3731454093.3448/st,small,507x507-pad,600x600,f8f8f8.jpg',
                ).image,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("หน้าหลัก"),
            ),
            ListTile(
              leading: Icon(Icons.dangerous),
              title: Text("หน้าอื่นๆ"),
            ),
          ],
        ),
      ),
      body: _menu[_currentIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: _menu
            .map(
              (e) => BottomNavigationBarItem(
                  icon: Icon(e['icon']), label: e['title']),
            )
            .toList(),
      ),
    );
  }
}
