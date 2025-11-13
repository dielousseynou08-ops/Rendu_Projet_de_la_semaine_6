import 'package:flutter/material.dart';
import 'package:ronkhlab_agro/widgets/widget_button.dart';

class PageRecommandation extends StatefulWidget {
  const PageRecommandation({super.key});

  @override
  State<PageRecommandation> createState() => _PageRecommandationState();
}

class _PageRecommandationState extends State<PageRecommandation> {
  @override
  Widget build(BuildContext context) {
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
              height: 300,
              width: 400,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            const SizedBox(height: 20),
            WidgetButton(name: 'Choix Optimal de Semences', onTap: () {}),
            const SizedBox(height: 5),
            WidgetButton(name: 'Conseils de Fertilisation', onTap: () {}),
            const SizedBox(height: 5),
            WidgetButton(name: 'Traitements biologiques', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
