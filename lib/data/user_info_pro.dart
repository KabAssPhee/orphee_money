enum TransactionTypePro { outflow, inflow }

enum ItemCategoryTypePro { fashion, grocery, payments }

class UserInfoPro {
  final String name;
  final String totalBalance;
  final String inflow;
  final String outflow;
  final List<TransactionPro> transactions;

  const UserInfoPro(
      {required this.name,
      required this.totalBalance,
      required this.inflow,
      required this.outflow,
      required this.transactions});
}

class TransactionPro {
  final ItemCategoryTypePro categoryTypePro;
  final TransactionTypePro transactionTypePro;
  final String itemCategoryNamePro;
  final String itemNamePro;
  final String amountPro;
  final String datePro;

  const TransactionPro({
    required this.categoryTypePro,
    required this.transactionTypePro,
    required this.itemCategoryNamePro,
    required this.itemNamePro,
    required this.amountPro,
    required this.datePro,
  });
}

const List<TransactionPro> transactionsPro1 = [
  TransactionPro(
      categoryTypePro: ItemCategoryTypePro.payments,
      transactionTypePro: TransactionTypePro.outflow,
      itemCategoryNamePro: 'Fournisseur',
      itemNamePro: "Achat d'emballage chez Kablan",
      amountPro: "30.000 XOF",
      datePro: "23, Mars"),
  // Transaction(
  //     categoryType: ItemCategoryType.fashion,
  //     transactionType: TransactionType.outflow,
  //     itemCategoryName: 'Shopping',
  //     itemName: "Magazin",
  //     amount: "35000 XOF",
  //     date: "24, Avril"),
  TransactionPro(
      categoryTypePro: ItemCategoryTypePro.payments,
      transactionTypePro: TransactionTypePro.inflow,
      itemCategoryNamePro: 'Savon Teint Métisse',
      itemNamePro: "Avance Astride",
      amountPro: "12000 XOF",
      datePro: "23, Juin"),
];

const List<TransactionPro> transactionsPro2 = [
  // Transaction(
  //     categoryType: ItemCategoryType.payments,
  //     transactionType: TransactionType.outflow,
  //     itemCategoryName: 'Loyer',
  //     itemName: "Transfer au ",
  //     amount: "15000 XOF",
  //     date: "5, Juin"),
  TransactionPro(
      categoryTypePro: ItemCategoryTypePro.payments,
      transactionTypePro: TransactionTypePro.inflow,
      itemCategoryNamePro: 'Savon Teint Métisse',
      itemNamePro: "Avance Mapau",
      amountPro: "20.000 XOF",
      datePro: "22, Juin"),
  TransactionPro(
      categoryTypePro: ItemCategoryTypePro.payments,
      transactionTypePro: TransactionTypePro.inflow,
      itemCategoryNamePro: 'Savon Teint Métisse',
      itemNamePro: "Paiement Cache",
      amountPro: "31.500 XOF",
      datePro: "22, Juin"),
  TransactionPro(
      categoryTypePro: ItemCategoryTypePro.payments,
      transactionTypePro: TransactionTypePro.inflow,
      itemCategoryNamePro: 'Savon Teint Clair',
      itemNamePro: "Paiement Cache",
      amountPro: "13.500 XOF",
      datePro: "22, Juin"),
];

const userdatapro = UserInfoPro(
    name: "Orphée",
    totalBalance: "77.000 XOF",
    inflow: "77.000 XOF",
    outflow: "330.000 XOF",
    transactions: transactionsPro1);
