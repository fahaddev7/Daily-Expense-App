import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function txadd;

  NewTransaction(this.txadd);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleinput = TextEditingController();
  DateTime selecteddate;
  final amountinput = TextEditingController();

  void adddata() {
    final titlemain = titleinput.text;
    final amountmain = double.parse(amountinput.text);

    if (titlemain.isEmpty || amountmain <= 0 || selecteddate == null) {
      return;
    }
    widget.txadd(
      titleinput.text,
      double.parse(amountinput.text),
      selecteddate,
    );

    Navigator.of(context).pop();
  }

  void showdate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selecteddate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleinput,
              // onChanged: (val) {
              //   title = val;
              // },
              onSubmitted: (_) => adddata(),
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: amountinput,
              // onChanged: (val){
              //   amount=val;
              // },
              onSubmitted: (_) => adddata(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selecteddate == null
                        ? "No date chosen"
                        : DateFormat.yMd().format(selecteddate),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                FlatButton(                  
                  onPressed: showdate,
                  child: Text(
                    "Choose Date",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: adddata,
              color: Colors.purple,
              child: Text("Add Expense",style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
