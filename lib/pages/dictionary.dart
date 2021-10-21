import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/models/dictionary_model.dart';
import 'package:interintel/widgets/dictionary_item_card.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  List<MapEntry<String, String>> numbers = [];
  String order = "Numeric Order";
  List<String> sortType = ["Alphabetical Order", "Numeric Order"];
  Map<String, String> dictionary = {
    '34': 'thirty-four',
    '90': 'ninety',
    '91': 'ninety-one',
    '21': 'twenty-one',
    '61': 'sixty-one',
    '9': 'nine',
    '2': 'two',
    '6': 'six',
    '3': 'three',
    '8': 'eight',
    '80': 'eighty',
    '81': 'eighty-one',
    '99': 'Ninety-Nine',
    '900': 'nine-hundred'
  };

  @override
  void initState() {
    super.initState();

    getList();
  }

  getList() {
    numbers = [];

    // Convert dictionary map to a list of its entries
    setState(() {
      numbers = dictionary.entries.toList();
    });

    switch (order) {
      case "Alphabetical Order":
        numbers.sort(
            (a, b) => a.value.toLowerCase().compareTo(b.value.toLowerCase()));
        break;

      case "Numeric Order":
        numbers.sort((a, b) => int.parse(a.key).compareTo(int.parse(b.key)));
        break;
    }
  }

  onSelected(String choice) {
    // When the drop down menu is selected we update "order" variable
    setState(() {
      order = choice;
    });

    //Then we get the updated list
    getList();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = DynamicTheme.of(context)!.theme == ThemeData.dark();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: isDark ? Colors.grey.shade900 : InterIntel.themeColor,
        title: Text(
          "Dictionary",
          style: GoogleFonts.fredokaOne(color: Colors.white),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
              size: 25.0,
            ),
            offset: const Offset(0.0, 50.0),
            onSelected: onSelected,
            itemBuilder: (BuildContext context) {
              return sortType.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Sort By: $order"),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return DictionaryItemCard(
                  item: DictionaryItem.fromJson(numbers[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
