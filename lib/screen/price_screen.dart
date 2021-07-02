import 'package:currency_app/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component/coins_data.dart';
import 'package:currency_app/services/networking.dart';
import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;


class PriceScreen extends StatefulWidget {
  static String route = '/priceScreen';
  final currencyPrice;
  PriceScreen({this.currencyPrice});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? currencyTxt;
  String bitcoinPrice = '?';
  String ethereumPrice = '?';
  String litecoinPrice = '?';
  bool isWaiting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🤑 Coin Ticker',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        leading: Container(
          height: 0,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PriceCard(
                currency: isWaiting ? '?' : bitcoinPrice,
                crypto: 'BTC',
                currencyTxt: currencyTxt,
              ),
              PriceCard(
                currency: isWaiting ? '?' : ethereumPrice,
                crypto: 'ETC',
                currencyTxt: currencyTxt,
              ),
              PriceCard(
                currency: isWaiting ? '?' : litecoinPrice,
                currencyTxt: currencyTxt,
                crypto: 'LTC',
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 40),
        color: Colors.blue,
        height: 180,
        child: getPicker(),
      ),
    );
  }

  CupertinoPicker buildCupertinoPicker() {
    List<Text> pickerItems = [
      for (String curr in currenciesList)
        Text(curr, style: TextStyle(color: Colors.white))
    ];

    return CupertinoPicker(
      children: pickerItems,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          currencyTxt = currenciesList[selectedIndex];
          getDataCoin();
        });
      },
    );
  }

  DropdownButton<String> buildDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [
      for (String curr in currenciesList)
        DropdownMenuItem(child: Text(curr), value: curr)
    ];

    return DropdownButton<String>(
      value: currencyTxt,
      onChanged: (String? newValue) async {
        setState(() {
          currencyTxt = newValue!;
          getDataCoin();
        });
      },
      hint: Text('Choice a currency', style: kPrimaryTextStyle,),
      items: dropDownItems,
      isDense: true,
      dropdownColor: Colors.black,
      style: kPrimaryTextStyle,
      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
      underline: Container(height: 0),
    );
  }

  void getDataCoin() async {
    try {
      isWaiting = true;
      var lastPrice = await NetWorkHelper.getData(currencyTxt);
      if (lastPrice != null) {
        setState(() {
          bitcoinPrice = lastPrice['bitcoin'];
          ethereumPrice = lastPrice['ethereum'];
          litecoinPrice = lastPrice['litecoin'];
          isWaiting = false;
        });
      }
    } catch (e) {
      buildDialog();
    }
  }

   buildDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Try again later\n It\'s not found now',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            // backgroundColor: Colors.blueGrey[200],
          );
        });
  }

  Widget getPicker() {
    // if (kIsWeb) return buildCupertinoPicker();

    try {
      if (Platform.isIOS)
        return buildCupertinoPicker();
      else
        return buildDropdownButton();
    } catch (e) {
      return buildDropdownButton();
    }
  }
}
