import 'package:flutter/material.dart';
import 'package:magazine_luiza/models/product.dart';
import 'package:magazine_luiza/provider/products.dart';
import 'package:magazine_luiza/style.dart';

//this package is running with --no-sound-null-safety
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueTheme,
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8
          ),
          child: Image.asset("assets/images/logo.jpg"),
        ),
        title: Text(
          "Ofertas do Dia",
          style: TextStyle(
            fontSize: 18
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: appBarGradient
            ),
          ),
          preferredSize: Size.fromHeight(3),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Product product = products.elementAt(index);

          int tempPayments = product.installments;
          String tempPrice = formatCurrency(product.price);
          String tempInstallmentPrice = formatCurrency(product.getInstallmentPrice(product.price));
          String tempHasInterest = product.interestRate > 0 ? "com ${product.interestRate}% de juros" : "sem juros";

          return ListTile(
            leading: Image.asset(
              product.photo,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  tempPrice,
                  style: TextStyle(
                    color: blueTheme,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${tempPayments}x de $tempInstallmentPrice $tempHasInterest",
                  style: TextStyle(
                    color: blueTheme,
                    fontSize: 10,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            trailing: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: (){
                setState(() {
                  product.isFavorite = !product.isFavorite;
                });
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_outline,
                size: 18,
                color: pinkIcon,
              ),
            ),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}

String formatCurrency(double value) {
  String result = MoneyMaskedTextController(
    initialValue: value,
    leftSymbol: 'R\$ ',
    thousandSeparator: '.',
    decimalSeparator: ',',
    precision: 2,
  ).text;
  
  return result;
}