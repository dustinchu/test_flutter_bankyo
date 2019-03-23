
import 'package:flutter/material.dart';

class DescribeCardItemModel {

  IconData icon;
  int tasksRemaining;
  double taskCompletion;
  Color backroundColor;
  DescribeCardItemModel( this.icon, this.tasksRemaining, this.taskCompletion, this.backroundColor);

}

final  cardItemModel = [
  DescribeCardItemModel(Icons.account_circle, 9,0.34,Color.fromRGBO(231, 129, 109, 1.0),),
  DescribeCardItemModel(Icons.work, 12, 0.24 , Color.fromRGBO(99, 138, 223, 1.0)),
  DescribeCardItemModel(Icons.laptop_windows, 9,0.34,Color.fromRGBO(90, 212, 211, 1.0),),
  DescribeCardItemModel(Icons.airplay, 9,0.34,Color.fromRGBO(211, 109, 140, 1.0),),
  DescribeCardItemModel(Icons.announcement, 9,0.34,Color.fromRGBO(157, 211, 109, 1.0),),
  DescribeCardItemModel(Icons.import_contacts, 9,0.34,Color.fromRGBO(130, 109, 211, 1.0),),
  DescribeCardItemModel(Icons.assignment, 9,0.34,Color.fromRGBO(200, 109, 211, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(111, 109, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(151, 109, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(251, 109, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(211, 209, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(211, 259, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(211, 59, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(111, 209, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(211, 59, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(151, 159, 176, 1.0),),
  DescribeCardItemModel(Icons.account_balance_wallet, 9,0.34,Color.fromRGBO(151, 209, 176, 1.0),),
  DescribeCardItemModel( Icons.home, 7, 0.32 ,  Color.fromRGBO(111, 194, 173, 1.0))

];