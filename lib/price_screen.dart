import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String CurrencyValue = 'USD';
  String bitcoin  = 'BTC';
  int rate;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  Future getData()async {
   http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$bitcoin/$CurrencyValue?apikey=C06C60A5-2405-4971-BA89-0841770C6A39'));
   var data = response.body;
  var decodedData= jsonDecode(data);
   double tempRate =  decodedData['rate'];
   setState(() {
     rate =  tempRate.toInt();
   });



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
            child: Card(
              margin: EdgeInsets.only(bottom: 400),
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $bitcoin =  $rate $CurrencyValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),



          Row(
              
            children: [

              Flexible(
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,

                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.cyan,
                  child: DropdownButton<String>(
                    value: CurrencyValue,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        CurrencyValue = newValue;
                        getData();
                      });
                    },
                    items: currenciesList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ),
              ),
              Flexible(
                child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.blueAccent,
                    child: DropdownButton<String>(
                      value: bitcoin,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          bitcoin = newValue;
                          getData();
                        });
                      },
                      items: cryptoList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
