// import 'dart:js';

import 'package:fire_app/widgets/new_transactions.dart';
import 'package:fire_app/widgets/transactions_list.dart';

import './models/transactions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Colors.purpleAccent,
        // fontFamily: 'Times New Roman',
        // appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle()))
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Utensils',
    //   amount: 12.15,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Groceries',
    //   amount: 52.44,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get recenttransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addtransaction(String txtitle, double txamount, DateTime selecteddate) {
    final newdata = Transaction(
      title: txtitle,
      amount: txamount,
      id: DateTime.now().toString(),
      date: selecteddate,
    );
                    
    setState(() {
      transactions.add(newdata);
    });
  }

  void deletetrans(String id) {
    setState(() {
      transactions.removeWhere((td) => td.id == id);
    });
  }

  void startaddnewtransaction() {
    showModalBottomSheet(
        context: (context),
        builder: (context) {
          return NewTransaction(addtransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => startaddnewtransaction(),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startaddnewtransaction(),
          ),
        ],
        title: Text("My Expenses"),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Transactionslist(transactions, deletetrans),
            ),
          ],
        ),
      ),
    );
  }
}
