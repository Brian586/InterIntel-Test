import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interintel/assistants/request_assistant.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/models/todo_item.dart';
import 'package:interintel/widgets/todo_card.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  List<TodoItem> todoList = [];
  bool showError = false;

  @override
  void initState() {
    super.initState();

    // When this page launches we get the todo list
    getTodoList();
  }

  void getTodoList() async {
    setState(() {
      showError = false;
    });

    // Declare the link
    String url = "https://jsonplaceholder.typicode.com/todos?_limit=5";

    // Get the map data and convert to a list of TodoItem(s)
    await RequestAssistant.getRequest(url).then((response) {
      if (response != "Failed") {
        setState(() {
          todoList = response
              .map<TodoItem>((todoItem) => TodoItem.fromJson(todoItem))
              .toList();
        });
      } else {
        setState(() {
          showError = true;
        });
      }
    });
  }

  // This widget displays Categories
  Widget displayCategories() {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.3,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Categories",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .apply(color: Colors.grey),
                ),
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 5.0),
                  child: Container(
                    width: size.width * 0.6,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              blurRadius: 4.0,
                              offset: Offset(1.0, 1.0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "3 Tasks",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .apply(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Business",
                            style: Theme.of(context).textTheme.headline5!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 5.0),
                  child: Container(
                    width: size.width * 0.6,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              blurRadius: 4.0,
                              offset: Offset(1.0, 1.0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "5 Tasks",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .apply(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Personal",
                            style: Theme.of(context).textTheme.headline5!,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // This widget displays error on screen and prompts a user to retry
  Widget displayError() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Sorry, an error occurred",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () => getTodoList(),
            child: Container(
              height: 30.0,
              width: 70.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: InterIntel.themeColor, width: 2.0)),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Retry",
                    style: TextStyle(color: InterIntel.themeColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = DynamicTheme.of(context)!.theme == ThemeData.dark();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: isDark ? Colors.grey.shade900 : InterIntel.themeColor,
        title: Text(
          "Response: Todo List",
          style: GoogleFonts.fredokaOne(color: Colors.white),
        ),
      ),

      // We display the TodoList here
      body: showError
          ? displayError()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  displayCategories(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "All Tasks",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .apply(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      TodoItem item = todoList[index];

                      return TodoCard(
                        item: item,
                      );
                    },
                  ),
                ],
              ),
            ),

      //Floating Action Button for adding more Todos
      floatingActionButton: FloatingActionButton(
        backgroundColor: InterIntel.themeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
