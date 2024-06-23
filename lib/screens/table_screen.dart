import 'package:flutter/material.dart';
import 'package:orphee_money/utils/constants.dart';

class BudgetTable extends StatefulWidget {
  @override
  State<BudgetTable> createState() => _BudgetTableState();
}

class _BudgetTableState extends State<BudgetTable> {
  int _selectedIndex = 0;

  final List<String> _months = ['Juin', 'Juillet', 'Août', 'Septembre'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Planification de Budget',
          style: TextStyle(color: fontDarker),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: defaultSpacing),
            child: Icon(Icons.add),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_months.length, (index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF5454D4) : Colors.blue[50],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      _months[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF5454D4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Revenus'),
            _buildTable(
              headers: ['Nom', 'Montant XOF', 'Fréquence'],
              rows: [
                ['Salaire', '500.000', 'Mois'],
                ['Vente de savon', '150.000', 'Mois'],
                ['Revenu TikTok', '15.000', 'Semaines'],
              ],
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Dépenses - charges fixes'),
            _buildTable(
              headers: ['Nom', 'Montant', 'Fréquence', 'Revenu'],
              rows: [
                ['Loyer', '150.000', 'Mois', 'Salaire'],
                ['Facture CIE', '', '', ''],
                ['Facture SODECI', '', '', ''],
                ['Scolarité enfants', '', '', ''],
              ],
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Dépenses - charges variables'),
            _buildTable(
              headers: ['Nom', 'Montant'],
              rows: [
                ['Shopping', ''],
                ['Resto', ''],
                ['Imprévus', ''],
                ['Maladie', ''],
                ['Voyage', ''],
              ],
            ),
            _buildSectionTitle('Épargne'),
            _buildTable(
              headers: ['Montant'],
              rows: [
                [
                  '',
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTable(
      {required List<String> headers, required List<List<String>> rows}) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: [
        TableRow(
          children: headers
              .map((header) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(header,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ))
              .toList(),
        ),
        ...rows
            .map((row) => TableRow(
                  children: row
                      .map((cell) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(cell),
                          ))
                      .toList(),
                ))
            .toList(),
      ],
    );
  }
}
