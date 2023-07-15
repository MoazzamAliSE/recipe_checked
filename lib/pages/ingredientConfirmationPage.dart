import 'package:flutter/material.dart';
import 'package:recipe_checked/controllers/storeController.dart';
import '../components/ingredientComponent.dart';
import 'dart:io';
import 'package:recipe_checked/utils/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:recipe_checked/data/appUser.dart';
import 'navBar.dart';

class IngredientConfirmationPage extends StatefulWidget {
  final List ingredientList;
  final File image;
  const IngredientConfirmationPage(this.ingredientList, this.image,
      {super.key});

  @override
  _IngredientConfirmationPageState createState() =>
      _IngredientConfirmationPageState();
}

class _IngredientConfirmationPageState
    extends State<IngredientConfirmationPage> {
  List<Map<dynamic, dynamic>> ingredientsToAdd = [];
  StoreController sc = StoreController();

  List<Widget> _generateList(ingredientList) {
    List<Widget> widgetList = [];
    int i;
    globals.deletedIndex = [];
    globals.finalIngredients = {};
    for (i = 0; i < ingredientList.length; i++) {
      widgetList.add(IngredientComponent(
        ingredientID: "",
        ingredientName: ingredientList[i],
        chosenQuantity: '1',
        chosenUnit: "units",
        expiryDate: DateTime.now().add(const Duration(days: 7)),
        checkboxVisibility: false,
        selectAll: false,
        cfmIndex: i,
      ));
    }
    print(globals.finalIngredients);
    for (var i = 0; i < widget.ingredientList.length; i++) {
      var ingredient = {
        'name': widget.ingredientList[i],
        'quantity': 1,
        'metric': 'units',
        'expiryDate': DateTime.now().add(const Duration(days: 7)),
      };
      globals.finalIngredients.add(ingredient);
    }
    print(globals.finalIngredients);
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ingredient Confirmation',
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: AspectRatio(
                aspectRatio: 2 / 1.3,
                child: Image.file(
                  widget.image,
                  width: 100,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              // padding: const EdgeInsets.all(20.0),
              children: _generateList(widget
                  .ingredientList), // <<<<< Note this change for the return type
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Send to store
                // print("globals.finalIngredients");
                // print(globals.finalIngredients);
                for (var i = 0; i < widget.ingredientList.length; i++) {
                  if (!globals.deletedIndex.contains(i)) {
                    ingredientsToAdd.add(globals.finalIngredients.elementAt(i));
                  }
                }
                // print(ingredientsToAdd);
                sc.addIngredients(ingredientsToAdd,
                    user.uid); // create ingredient obj then add
                globals.finalIngredients = {};
                globals.deletedIndex = [];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Navbar(
                            selectedIndex: 2,
                          )),
                );

                // Navigator.pushNamed(context, 'Store');
              },
              style: ElevatedButton.styleFrom(
                  // fixedSize: Size(170, 36),
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }
}
