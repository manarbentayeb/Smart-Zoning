import 'package:flutter/material.dart';
import 'package:mobilis/widgets/app_bar.dart';
import 'auth_page.dart';  

class ProfilePage extends StatelessWidget {
  final green = const Color(0xFF4CAF50);

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          CustomAppBar(currentPage: 'profile'),
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 250,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: green.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Icon(Icons.person_outline, size: 120, color: green.withOpacity(0.7)),
                              Positioned(
                                bottom: 0,
                                right: 12,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 14,
                                  child: Icon(Icons.edit, size: 16, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Nom et Prenom",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                        ),
                        child: const Text(
                          "Paramètres",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AuthPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                        ),
                        child: const Text(
                          "Déconnexion",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 500,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: 800,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildFormRow([
                                buildDisplayBox("Nom", "Mohammed"),
                                buildDisplayBox("Prenom", "Khalil"),
                                buildDisplayBox("Role", "Manager"),
                              ]),
                              const SizedBox(height: 20),
                              buildFormRow([
                                buildDisplayBox("CSM", "CSM123"),
                                buildDisplayBox("Agence", "Agence X"),
                                buildDisplayBox("Wilaya", "Alger"),
                              ]),
                              const SizedBox(height: 20),
                              buildFormRow([
                                buildDisplayBox("Email", "mohammedkhalil@mobilis.dz"),
                                buildDisplayBox("Numéro de téléphone", "0512843951"),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormRow(List<Widget> fields) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: fields,
    );
  }

  Widget buildDisplayBox(String label, String value) {
    return SizedBox(
      width: 240,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
