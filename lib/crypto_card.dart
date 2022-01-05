import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String coinName;
  final String currency;
  final int rate;

  const CryptoCard({this.coinName, this.currency, this.rate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $coinName = ${rate == 0 ? '?' : rate}  $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
