import 'package:fire_app/models/transactions.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Transactionslist extends StatelessWidget {
  final List<Transaction> alltransaction;
  final Function deletetx;
  Transactionslist(this.alltransaction, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: alltransaction.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("No transactions added yet!"),
                // SizedBox(height:20);
                Image.asset(
                  'assets/images/1.png',
                  // fit: BoxFit.cover,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(elevation: 8.0,
                margin: EdgeInsets.all(8.0),
                
                                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(fit: BoxFit.contain,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "\$${alltransaction[index].amount.toStringAsFixed(2)}",),
                        ),
                      ),
                    ),
                    title: Text(
                      alltransaction[index].title,style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(alltransaction[index].date),
                    ),
                    trailing: IconButton(
                      color:Theme.of(context).errorColor,
                      icon: Icon(
                        Icons.delete, 
                      ),
                      onPressed: () => deletetx(alltransaction[index].id),
                    ),
                  ),
                );
              },
              itemCount: alltransaction.length,
            ),
    );
  }
}
