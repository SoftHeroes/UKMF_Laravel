import 'package:flutter/material.dart';
import './product.dart';

class ProductManager extends StatefulWidget {
  final String startingproduct;
  ProductManager({this.startingproduct = 'Starting test'}) {
    print('ProductManager widget constructor');
  }

  @override
  State<StatefulWidget> createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
    print('_ProductManagerState widget initState');
    _products.add(widget.startingproduct);
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('_ProductManagerState widget didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('_ProductManagerState widget build');
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          onPressed: () {
            setState(() {
              _products.add('Pizza new Card');
            });
          },
          child: Text('Add'),
          color: Theme.of(context).primaryColor,
        ),
      ),
      Product(_products)
    ]);
  }
}
