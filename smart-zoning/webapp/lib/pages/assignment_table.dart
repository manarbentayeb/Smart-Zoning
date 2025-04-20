import 'package:flutter/material.dart';
import 'package:mobilis/widgets/app_bar.dart';
import 'package:mobilis/widgets/footer.dart';

class AssignmentTablePage extends StatelessWidget {
  const AssignmentTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {"zone": "ZONE 01", "pdv": "Nom de pdv", "etat": "", "representative": ""},
      {"zone": "ZONE 02", "pdv": "Nom de pdv", "etat": "", "representative": ""},
      {"zone": "ZONE 03", "pdv": "Nom de pdv", "etat": "", "representative": ""},
      {"zone": "ZONE 04", "pdv": "Nom de pdv", "etat": "", "representative": ""},
      {"zone": "ZONE 05", "pdv": "Nom de pdv", "etat": "", "representative": ""},
      {"zone": "ZONE 06", "pdv": "Nom de pdv", "etat": "", "representative": ""},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomAppBar(currentPage: 'affectations'), 
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Tableau des Affectations',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 64,
                      child: Container(
                        color: Color.fromARGB(207, 255, 255, 255),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                          columns: const [
                            DataColumn(label: Text("Les Zones", style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text("Les PDV", style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text("Etat", style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text("Représentant", style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                          rows: data.map((row) {
                            return DataRow(
                              cells: [
                                DataCell(Text(row['zone']!)),
                                DataCell(Text(row['pdv']!)),
                                DataCell(Text(row['etat'] ?? '')),
                                DataCell(
                                  row['representative'] == null || row['representative']!.isEmpty
                                      ? MouseRegion(
                                          onEnter: (_) {
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) => const AssignRepresentativeDialog(),
                                              );
                                            },
                                            child: const Text(
                                              'Assigner',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(row['representative']!),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2DB34B),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    child: const Text(
                      "Exporter en PDF",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const CustomFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AssignRepresentativeDialog extends StatelessWidget {
  const AssignRepresentativeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = [
      {
        "name": "Ahmad Rosser",
        "phone": "5684236526",
        "email": "AhmadRosser1@mobilis.dz"
      },
      {
        "name": "Ahmad Rosser",
        "phone": "5684236527",
        "email": "AhmadRosser2@mobilis.dz"
      },
    ];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: const [
                  Expanded(child: Text("#")),
                  Expanded(flex: 2, child: Text("Nom")),
                  Expanded(flex: 3, child: Text("Email")),
                ],
              ),
            ),
            ...users.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final user = entry.value;
              return Container(
                color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: Text(index.toString())),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(user['phone']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(user['email']!, style: const TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
