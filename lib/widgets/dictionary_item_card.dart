import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:interintel/models/dictionary_model.dart';

class DictionaryItemCard extends StatelessWidget {
  final DictionaryItem? item;

  const DictionaryItemCard({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          item!.key!,
          style: Theme.of(context).textTheme.headline6,
        ),
        title: Text(
          item!.value!,
          style:
              Theme.of(context).textTheme.caption!.apply(fontSizeFactor: 1.2),
        ),
      ),
    );
  }
}
