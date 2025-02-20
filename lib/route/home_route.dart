import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/chart.dart';
import '/components/transaction_form.dart';
import '/components/transaction_list.dart';
import '/models/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Inicializa observador para telas em background
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Saída Antiga',
      value: 400,
      date: DateTime.now().subtract(Duration(days: 30)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    // Fechar modal
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            icon: Icon(icon),
            onPressed: fn,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final textScaler = MediaQuery.textScalerOf(context).scale(20);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final iconList =
        Platform.isIOS ? CupertinoIcons.app_badge_fill : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.app_badge : Icons.show_chart;

    final actions = <Widget>[
      if (isLandScape)
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = AppBar(
        title: Text(
          'Despesas Pessoais',
          style: TextStyle(
            fontSize: textScaler,
          ),
        ),
        actions: actions
        // backgroundColor: Colors.purple,
        );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandScape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('Exibir Gráfico'),
            //       Switch.adaptive(
            //           activeColor: Theme.of(context).primaryColor,
            //           value: _showChart,
            //           onChanged: (value) {
            //             setState(() {
            //               _showChart = value;
            //             });
            //           }),
            //     ],
            //   ),
            if (_showChart || !isLandScape)
              Container(
                height: availableHeight * (isLandScape ? 0.8 : 0.25),
                child: Chart(
                  recentTransaction: _recentTransactions,
                ),
              ),
            if (!_showChart || !isLandScape)
              Container(
                height: availableHeight * (isLandScape ? 1 : 0.65),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.amber,
                    shape: const CircleBorder(),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
