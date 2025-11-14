import 'package:flutter/material.dart';
import 'package:ronkhlab_agro/pages/ajout_parcelle.dart';
import 'package:ronkhlab_agro/widgets/get_chams.dart';

class PageParcelles extends StatefulWidget {
  const PageParcelles({super.key});

  @override
  State<PageParcelles> createState() => _PageParcellesState();
}

class _PageParcellesState extends State<PageParcelles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'RonkhLab_Agro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            height: 54,
            width: double.infinity,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ajouter les informations de Champ !",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AjoutParcelles(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 24, color: Colors.black),
                ),
              ],
            ),
          ),

          const Expanded(child: ChampInformation()),
        ],
      ),
    );
  }
}
