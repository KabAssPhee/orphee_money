import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orphee_money/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetTablePro extends StatefulWidget {
  @override
  State<BudgetTablePro> createState() => _BudgetTableProState();
}

class _BudgetTableProState extends State<BudgetTablePro> {
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
      fixedExpensesControllers = _loadControllers(prefs, 'fixedExpenses', 4);
      variableExpensesControllers =
          _loadControllers(prefs, 'variableExpenses', 5);
      savingsControllers = _loadControllers(prefs, 'savings', 4);
      supplierExpensesControllers =
          _loadControllers(prefs, 'supplierExpenses', 5);
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
          'Charges d\'exploitations',
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
            _buildSection(
              title: "Charges d'exploitation - Fournisseurs",
              headers: ['Nom', 'Produits fournis', 'Date', 'Prix XOF', ''],
              controllers: fixedExpensesControllers,
              columns: 4,
            ),
            _buildSection(
              title: "Charges d'exploitation - Produits en Vente",
              headers: [
                'Produits',
                'Quantités en stock',
                "Prix d'achat",
                'Prix de vente',
                'Bénéfice Attendu',
                ''
              ],
              controllers: variableExpensesControllers,
              columns: 5,
            ),
            _buildSection(
              title: 'Recettes - Ventes en une fois',
              headers: [
                'Nom du Produit',
                'Réduction',
                'Prix final',
                'Date',
                ''
              ],
              controllers: savingsControllers,
              columns: 4,
            ),
            _buildSection(
              title: 'Recettes - Ventes en plusieurs fois',
              headers: [
                'Nom du Produit',
                'Nom du Client',
                'Avance',
                'Date',
                'soldé',
                ''
              ],
              controllers: supplierExpensesControllers,
              columns: 5,
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
