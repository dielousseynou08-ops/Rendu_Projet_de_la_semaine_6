import 'package:flutter/material.dart';
import 'package:ronkhlab_agro/widgets/widget_button.dart';

class PageSaisons extends StatefulWidget {
  const PageSaisons({super.key});

  @override
  State<PageSaisons> createState() => _PageSaisonsState();
}

class _PageSaisonsState extends State<PageSaisons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
              height: 300,
              width: 400,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            const SizedBox(height: 20),
            WidgetButton(name: 'Saisons et Climat', onTap: () {}),
            const SizedBox(height: 5),
            WidgetButton(name: 'Semis', onTap: () {}),
            const SizedBox(height: 5),
            WidgetButton(name: 'Sarclage', onTap: () {}),
            const SizedBox(height: 5),
            WidgetButton(name: 'Irrigation', onTap: () {}),
            const SizedBox(height: 5),
            WidgetButton(name: 'Récoltes', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
