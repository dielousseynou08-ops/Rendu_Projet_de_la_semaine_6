import 'package:flutter/material.dart';
import 'package:ronkhlab_agro/pages/page_meteo.dart';
import 'package:ronkhlab_agro/pages/page_parcelles.dart';
import 'package:ronkhlab_agro/pages/page_recommandation.dart';
import 'package:ronkhlab_agro/pages/saison.dart';

class WidgetHomeMenu extends StatelessWidget {
  final List<Map<String, dynamic>> listMenu;
  const WidgetHomeMenu({required this.listMenu, super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const PageParcelles(),
      const PageMeteo(),
      const PageRecommandation(),
      const PageSaisons(),
    ];
    return Container(
      margin: EdgeInsets.all(15),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemCount: listMenu.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => pages[index]));
            },
            child: Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(listMenu[index]['icon'], scale: 8),
                  const SizedBox(height: 5),
                  Text(
                    listMenu[index]['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
