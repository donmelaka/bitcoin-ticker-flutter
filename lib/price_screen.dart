import 'package:bitcoin_ticker/exchange_rate_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, int> ratesMap = {'BTC': 0, 'ETH': 0, 'LTC': 0};

  int currentExchangeRateBtc = 0;
  int currentExchangeRateEth = 0;
  int currentExchangeRateLtc = 0;
  ExchangeRateHelper exchangeRateHelper = ExchangeRateHelper();

  @override
  initState() {
    updateRates('USD');
    super.initState();
  }

  updateRates(String target) {
    ratesMap.keys.forEach((element) async {
      var specificExchangeRate =
          await exchangeRateHelper.getSpecificExchangeRate(element, target);
      print('returned value $specificExchangeRate');
      setState(() {
        ratesMap[element] = specificExchangeRate.round();
        print(ratesMap[element]);
      });
    });
  }

  Widget iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: currenciesList.length.toDouble(),
      scrollController: FixedExtentScrollController(initialItem: 19),
      children: currenciesList.map((e) => Text(e)).toList(growable: false),
      onSelectedItemChanged: (val) {
        setState(() {
          selectedCurrency = currenciesList[val];
          updateRates(selectedCurrency);
        });
      },
    );
  }

  Widget androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (val) {
        setState(() {
          selectedCurrency = val;
          print(selectedCurrency);
        });
      },
      items: [
        ...currenciesList
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(growable: false)
      ],
      dropdownColor: Colors.lightBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = ${ratesMap['BTC'] == 0 ? '?' : ratesMap['BTC']}  $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ${ratesMap['ETH'] == 0 ? '?' : ratesMap['ETH']}  $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ${ratesMap['LTC'] == 0 ? '?' : ratesMap['LTC']}  $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
