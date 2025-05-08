import 'package:flutter/material.dart';
import 'package:mobilis/widgets/app_bar.dart';
import 'package:mobilis/widgets/footer.dart';

class AssignmentTablePage extends StatefulWidget {
  const AssignmentTablePage({super.key});

  @override
  State<AssignmentTablePage> createState() => _AssignmentTablePageState();
}

class _AssignmentTablePageState extends State<AssignmentTablePage> {
  int? selectedZone;
  final Map<int, Set<int>> selectedPDVs = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _toggleSelection(int zoneIndex, int pdvIndex) {
    setState(() {
      final selected = selectedPDVs.putIfAbsent(zoneIndex, () => <int>{});
      if (selected.contains(pdvIndex)) {
        selected.remove(pdvIndex);
      } else {
        selected.add(pdvIndex);
      }
    });
  }

  void _showSearchPanel(BuildContext context, int zoneIndex) {
    _searchController.clear();
    _searchQuery = '';

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: 400,
            height: 450,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Text(
                    'Assigner un représentant pour Zone ${zoneIndex.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Rechercher par email...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() => _searchQuery = value.trim().toLowerCase());
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Résultats :", style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: _filteredEmails(_searchQuery)
                        .map((email) => _emailResultTile(email))
                        .toList(),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Fermer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _filteredEmails(String query) {
    final emails = ["personne1@mobilis.dz", "personne2@mobilis.dz", "personne3@mobilis.dz"];
    if (query.isEmpty) return emails;
    return emails.where((email) => email.toLowerCase().contains(query)).toList();
  }

  static Widget _emailResultTile(String email) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_outline),
          const SizedBox(width: 10),
          Text(email, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  void _showPDVList(BuildContext context, int zoneIndex, {bool selectable = false}) {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: 350,
            height: 400,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Text(
                    selectable
                        ? 'Spécifier les PDVs pour Zone ${zoneIndex.toString().padLeft(2, '0')}'
                        : 'Liste des PDVs pour Zone ${zoneIndex.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: 20,
                      itemBuilder: (context, i) {
                        final pdvTitle = 'PDV ${i + 1}';
                        final pdvSubtitle = 'Adresse exemple ${i + 1}';
                        if (selectable) {
                          final isSelected = selectedPDVs[zoneIndex]?.contains(i) ?? false;
                          return ListTile(
                            onTap: () => setState(() => _toggleSelection(zoneIndex, i)),
                            leading: Checkbox(
                              value: isSelected,
                              onChanged: (_) => setState(() => _toggleSelection(zoneIndex, i)),
                            ),
                            title: Text(pdvTitle),
                            subtitle: Text(pdvSubtitle),
                            tileColor: i % 2 == 0 ? Colors.grey[100] : null,
                          );
                        } else {
                          return ListTile(
                            leading: const Icon(Icons.store),
                            title: Text(pdvTitle),
                            subtitle: Text(pdvSubtitle),
                            tileColor: i % 2 == 0 ? Colors.grey[100] : null,
                          );
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Fermer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _zoneButton(int index) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          textStyle: const TextStyle(fontSize: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () => _showPDVList(context, index),
        child: Text('Zone ${index.toString().padLeft(2, '0')}'),
      ),
    );
  }

  Widget _assignerButton(int index) {
    return Center(
      child: MouseRegion(
        onEnter: (_) => setState(() => selectedZone = index),
        onExit: (_) => setState(() => selectedZone = null),
        child: GestureDetector(
          onTap: () => _showSearchPanel(context, index),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: selectedZone == index ? Colors.green : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
            child: const Text('Attribuer'),
          ),
        ),
      ),
    );
  }

  Widget _specifyPDVButton(int index) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _showPDVList(context, index, selectable: true),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text("Spécifier les PDVs"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomAppBar(currentPage: 'affectations'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Affectations par Zone',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(color: Colors.grey),
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.black12),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                'Les Zones',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                'Les Représentants',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                'Sélectionner des PDVs',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(8, (index) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: _zoneButton(index + 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: _assignerButton(index + 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: _specifyPDVButton(index + 1),
                            ),
                          ],
                        );
                      }),
                    ],
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
