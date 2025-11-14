import 'package:flutter/material.dart';
import 'package:ronkhlab_agro/widgets/widget_home_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> listMenu = [
      {'name': 'Parcelles', 'icon': 'assets/icons/endroit.png'},
      {'name': 'Météo', 'icon': 'assets/icons/domaine.png'},
      {
        'name': 'Conseils',
        'icon': 'assets/icons/lagriculture-de-precision.png',
      },
      {'name': 'Climat', 'icon': 'assets/icons/jardinage.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'RonkhLab_Agro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(15),
                child: Image.asset(
                  'assets/images/slider01.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            WidgetHomeMenu(listMenu: listMenu),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[300], // ← Couleur quand sélectionné
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // index sélectionné
          });
        },
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Communauté', icon: Icon(Icons.group)),
          BottomNavigationBarItem(
            label: 'Notification',
            icon: Icon(Icons.notification_add),
          ),
          BottomNavigationBarItem(label: 'Profil', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
