enum TransactionType { outflow, inflow }

enum ItemCategoryType { fashion, grocery, payments }

class UserInfo {
  final String name;
  final String totalBalance;
  final String inflow;
  final String outflow;
  final List<Transaction> transactions;

  const UserInfo(
      {required this.name,
      required this.totalBalance,
      required this.inflow,
      required this.outflow,
      required this.transactions});
}

class Transaction {
  final ItemCategoryType categoryType;
  final TransactionType transactionType;
  final String itemCategoryName;
  final String itemName;
  final String amount;
  final String date;

  const Transaction({
    required this.categoryType,
    required this.transactionType,
    required this.itemCategoryName,
    required this.itemName,
    required this.amount,
    required this.date,
  });
}

const List<Transaction> transactions1 = [
  Transaction(
      categoryType: ItemCategoryType.fashion,
      transactionType: TransactionType.outflow,
      itemCategoryName: 'Imprévus',
      itemName: "Aléatoire",
      amount: "25000 XOF",
      date: "23, Mars"),
  Transaction(
      categoryType: ItemCategoryType.fashion,
      transactionType: TransactionType.outflow,
      itemCategoryName: 'Shopping',
      itemName: "Magazin",
      amount: "35000 XOF",
      date: "24, Avril"),
];

const List<Transaction> transactions2 = [
  Transaction(
      categoryType: ItemCategoryType.payments,
      transactionType: TransactionType.outflow,
      itemCategoryName: 'Loyer',
      itemName: "Transfer à mapau",
      amount: "15000 XOF",
      date: "5, Juin"),
  Transaction(
      categoryType: ItemCategoryType.fashion,
      transactionType: TransactionType.outflow,
      itemCategoryName: 'Imprévus',
      itemName: "Aléatoire",
      amount: "40000 XOF",
      date: "7, Juin"),
  Transaction(
      categoryType: ItemCategoryType.fashion,
      transactionType: TransactionType.outflow,
      itemCategoryName: 'Imprévus',
      itemName: "Aléatoire",
      amount: "50000 XOF",
      date: "8, Juin"),
];

const userdata = UserInfo(
    name: "Orphée",
    totalBalance: "500.000 XOF",
    inflow: "300.000 XOF",
    outflow: "200.000 XOF",
    transactions: transactions1);
