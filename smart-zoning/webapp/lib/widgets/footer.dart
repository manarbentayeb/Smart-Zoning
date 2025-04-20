import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      color: const Color(0xFFE9F4EB),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Transform.scale(
                  scale: 3,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/mobilis-logo.png',
                    height: 50,
                  ),
                ),
              ),
              const Text(
                'Ensemble, nous construisons le future',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _FooterColumn(
                items: ['Accueil', 'Zones', 'Affectations'],
              ),
              _FooterColumn(
                items: ['Paramètres', 'Terms and Polices', 'Conditions et Politiques'],
              ),
              _FooterColumn(
                items: ['Facebook', 'Instagram', 'WhatsApp'],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final List<String> items;

  const _FooterColumn({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  item,
                  style: const TextStyle(color: Colors.grey),
                ),
              ))
          .toList(),
    );
  }
}
