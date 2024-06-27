import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orphee_money/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetTable extends StatefulWidget {
  @override
  State<BudgetTable> createState() => _BudgetTableState();
}

class _BudgetTableState extends State<BudgetTable> {
  int _selectedIndex = 0;

  final List<String> _months = ['Juin', 'Juillet', 'Août', 'Septembre'];
//DATA TABLE
  List<List<TextEditingController>> fixedExpensesControllers = [];
  List<List<TextEditingController>> variableExpensesControllers = [];
  List<List<TextEditingController>> savingsControllers = [];
  List<List<TextEditingController>> supplierExpensesControllers = [];
  // List<List<TextEditingController>> salesExpensesControllers = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      fixedExpensesControllers = _loadControllers(prefs, 'fixedExpenses', 3);
      variableExpensesControllers =
          _loadControllers(prefs, 'variableExpenses', 4);
      savingsControllers = _loadControllers(prefs, 'savings', 3);
      supplierExpensesControllers =
          _loadControllers(prefs, 'supplierExpenses', 2);
      // salesExpensesControllers = _loadControllers(prefs, 'salesExpenses', 5);
    });
  }

  List<List<TextEditingController>> _loadControllers(
      SharedPreferences prefs, String key, int columns) {
    List<String>? data = prefs.getStringList(key);
    if (data != null) {
      return data.map((row) {
        List<String> cells = jsonDecode(row).cast<String>();
        return cells.map((cell) => TextEditingController(text: cell)).toList();
      }).toList();
    }
    return List.generate(1,
        (index) => List.generate(columns, (index) => TextEditingController()));
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
        'fixedExpenses', _saveControllers(fixedExpensesControllers));
    await prefs.setStringList(
        'variableExpenses', _saveControllers(variableExpensesControllers));
    await prefs.setStringList('savings', _saveControllers(savingsControllers));
    await prefs.setStringList(
        'supplierExpenses', _saveControllers(supplierExpensesControllers));
    // await prefs.setStringList(
    // 'salesExpenses', _saveControllers(salesExpensesControllers));
  }

  List<String> _saveControllers(List<List<TextEditingController>> controllers) {
    return controllers.map((row) {
      List<String> cells = row.map((controller) => controller.text).toList();
      return jsonEncode(cells);
    }).toList();
  }

  void addRow(
      List<List<TextEditingController>> controllers, int numberOfColumns) {
    setState(() {
      controllers.add(
          List.generate(numberOfColumns, (index) => TextEditingController()));
    });
  }

  void removeRow(List<List<TextEditingController>> controllers, int rowIndex) {
    setState(() {
      controllers[rowIndex].forEach((controller) => controller.dispose());
      controllers.removeAt(rowIndex);
    });
  }

  // Dispose

  @override
  void dispose() {
    fixedExpensesControllers
        .forEach((row) => row.forEach((controller) => controller.dispose()));
    variableExpensesControllers
        .forEach((row) => row.forEach((controller) => controller.dispose()));
    savingsControllers
        .forEach((row) => row.forEach((controller) => controller.dispose()));
    supplierExpensesControllers
        .forEach((row) => row.forEach((controller) => controller.dispose()));
    // salesExpensesControllers
    // .forEach((row) => row.forEach((controller) => controller.dispose()));
    super.dispose();
  }

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
            // _buildSectionTitle('Revenus'),
            // _buildTable(
            //   headers: ['Nom', 'Montant XOF', 'Fréquence'],
            //   rows: [
            //     ['Salaire', '500.000', 'Mois'],
            //     ['Vente de savon', '150.000', 'Mois'],
            //     ['Revenu TikTok', '15.000', 'Semaines'],
            //   ],
            // ),
            // SizedBox(height: 16),
            // _buildSectionTitle('Dépenses - charges fixes'),
            // _buildTable(
            //   headers: ['Nom', 'Montant', 'Fréquence', 'Revenus'],
            //   rows: [
            //     ['Loyer', '150.000', 'Mois', 'Salaire'],
            //     ['Facture CIE', '50.000', 'Mois', 'Salaire'],
            //     ['Facture SODECI', '10.000', 'Mois', 'Salaire'],
            //     ['Scolarité enfants', '75.000', 'Mois', 'Salaire'],
            //   ],
            // ),
            // SizedBox(height: 16),
            // _buildSectionTitle('Dépenses - charges variables'),
            // _buildTable(
            //   headers: ['Nom', 'Montant', 'Revenus'],
            //   rows: [
            //     ['Shopping', '20.000', 'Salaire'],
            //     ['Resto', '50.000', 'Salaire'],
            //     ['Imprévus', '50.000', 'Salaire'],
            //     ['Maladie', '50.000', 'Salaire'],
            //     ['Voyage', '60.000', 'TikTok'],
            //   ],
            // ),
            // _buildSectionTitle('Épargne'),
            // _buildTable(
            //   headers: ['Montant', 'Revenus'],
            //   rows: [
            //     ['150.000', 'Vente de Savon'],
            //   ],
            // ),
            //NOUVEAU TABLEAU
            _buildSection(
              title: 'Revenus',
              headers: ['Nom', 'Montant XOF', 'Fréquence', ''],
              controllers: fixedExpensesControllers,
              columns: 3,
            ),
            _buildSection(
              title: 'Dépenses - charges fixes',
              headers: ['Nom', 'Montant XOF', 'Fréquence', 'Revenus', ''],
              controllers: variableExpensesControllers,
              columns: 4,
            ),
            _buildSection(
              title: 'Dépenses - charges variables',
              headers: ['Nom', 'Montant', 'Revenus', ''],
              controllers: savingsControllers,
              columns: 3,
            ),
            _buildSection(
              title: 'Épargne',
              headers: ['Montant XOF', 'Revenus', ''],
              controllers: supplierExpensesControllers,
              columns: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _saveData,
                child: Text('Valider'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSectionTitle(String title) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Text(title,
  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  //   );
  // }

  // Widget _buildTable(
  //     {required List<String> headers, required List<List<String>> rows}) {
  //   return Table(
  //     border: TableBorder.all(color: Colors.black),
  //     children: [
  //       TableRow(
  //         children: headers
  //             .map((header) => Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(header,
  //                       style: TextStyle(fontWeight: FontWeight.bold)),
  //                 ))
  //             .toList(),
  //       ),
  //       ...rows
  //           .map((row) => TableRow(
  //                 children: row
  //                     .map((cell) => Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(cell),
  //                         ))
  //                     .toList(),
  //               ))
  //           .toList(),
  //     ],
  //   );
  // }

  //Nouvelle fonction
  Widget _buildSection(
      {required String title,
      required List<String> headers,
      required List<List<TextEditingController>> controllers,
      required int columns}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BudgetInputTable(
              headers: headers,
              controllers: controllers,
              onRemoveRow: (index) => removeRow(controllers, index),
            ),
          ),
          ElevatedButton(
            onPressed: () => addRow(controllers, columns),
            child: Text('Ajouter une ligne'),
          ),
        ],
      ),
    );
  }
}

//Nouvelles classes

class BudgetInputTable extends StatelessWidget {
  final List<String> headers;
  final List<List<TextEditingController>> controllers;
  final Function(int) onRemoveRow;

  BudgetInputTable(
      {required this.headers,
      required this.controllers,
      required this.onRemoveRow});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: DataTable(
        columnSpacing: 10.0,
        columns: headers
            .map((header) =>
                DataColumn(label: Text(header, style: TextStyle(fontSize: 12))))
            .toList(),
        rows: List<DataRow>.generate(
          controllers.length,
          (index) => DataRow(
            cells: [
              ...controllers[index].map((controller) {
                return DataCell(
                  Container(
                    width: 80,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                );
              }).toList(),
              DataCell(
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onRemoveRow(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
