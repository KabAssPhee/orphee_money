import 'package:flutter/material.dart';
import 'package:orphee_money/utils/constants.dart';

class BudgetTablePro extends StatefulWidget {
  @override
  State<BudgetTablePro> createState() => _BudgetTableProState();
}

class _BudgetTableProState extends State<BudgetTablePro> {
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
        padding: EdgeInsets.all(8.0),
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
            _buildSectionTitle('Charges d\'exploitation - Fournisseurs'),
            _buildTable(
              headers: ['Nom', 'Produits fournis', 'Prix XOF'],
              rows: [
                ['Mme Diop', 'Savon', '300.000'],
                ['M. Kablan', 'Emballage', '30.000'],
              ],
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Charges d\'exploitation - Produits en Vente'),
            _buildTable(
              headers: [
                'Produit',
                'Quantités en stock',
                'Prix d\'achat',
                'Prix de vente',
                'Bénéfice Attendu'
              ],
              rows: [
                ['Savon Teint Clair', '30', '', '15.000', '150.000'],
                ['Savon Teint Métisse', '12', '', '35.000', '120.000'],
              ],
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Recettes - Ventes en une fois'),
            _buildTable(
              headers: ['Nom du Produit', 'Réduction', 'Prix final', 'Date'],
              rows: [
                ['Savon Teint Clair', '10%', '13.500', '05-06-2024'],
                ['Savon Teint Métisse', '10%', '31.500', '06-06-2024'],
              ],
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Recettes - Ventes en plusieurs fois'),
            _buildTable(
              headers: [
                'Nom du Produit',
                'Nom du client',
                'Avance',
                'Date',
                'Soldé'
              ],
              rows: [
                [
                  'Savon Teint Métisse',
                  'Mlle. Marie-Paul Nassa',
                  '20.000',
                  '',
                  'Non'
                ],
                [
                  'Savon Teint Métisse',
                  'Mlle. Ezékiel Astride',
                  '12.000',
                  '',
                  'Non'
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
