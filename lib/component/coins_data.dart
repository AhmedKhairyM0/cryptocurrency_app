import 'package:currency_app/constant.dart';
import 'package:flutter/material.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

class PriceCard extends StatelessWidget {
  final String? crypto, currencyTxt;
  final currency;
  PriceCard({this.currency, this.crypto, this.currencyTxt});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 12,
      color: Colors.blue,
      margin: EdgeInsets.all(30.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          '1 $crypto = $currency $currencyTxt',
          style: kPrimaryTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}