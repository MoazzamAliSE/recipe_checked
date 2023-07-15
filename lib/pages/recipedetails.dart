import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_checked/controllers/favouritesController.dart';
import 'package:recipe_checked/controllers/recipeController.dart';
import 'package:recipe_checked/data/appUser.dart';
import 'package:html/parser.dart';
import 'package:recipe_checked/utils/constants.dart';

class RecipeDetails extends StatefulWidget {
  int recipeID;
  String recipeName;
  bool addedTofav;
  // String favID;

  RecipeDetails(
      {super.key,
      required this.recipeID,
      required this.recipeName,
      this.addedTofav = false});

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  RecipeController rc = RecipeController();
  FavouritesController fc = FavouritesController();
  var result;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _addFavConfirmation(BuildContext context) {
    final user = Provider.of<AppUser>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Press ok to add this recipe to your favourites!",
                style: Theme.of(context).textTheme.bodyMedium),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      child: const Text('cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  MaterialButton(
                      child: const Text('ok'),
                      onPressed: () {
                        fc.addFavourite(
                            widget.recipeID, widget.recipeName, user.uid);
                        setState(() {
                          widget.addedTofav = true;
                        });
                        // setState(() {
                        //   _visibilityTag = false;
                        // });
                        Navigator.pop(context);
                      }),
                ],
              )
            ],
          );
        });
  }

  // _deleteFavConfirmation(BuildContext context, String docID) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text("Press ok to add this recipe to your favourites!",
  //               style: Theme.of(context).textTheme.bodyText2),
  //           actions: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 MaterialButton(
  //                     child: Text('cancel'),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     }),
  //                 MaterialButton(
  //                     child: Text('ok'),
  //                     onPressed: () {
  //                       fc.deleteFavourite(docID);
  //                       setState(() {
  //                         widget.addedTofav = false;
  //                         // widget.favID = null;
  //                       });
  //                       // setState(() {
  //                       //   _visibilityTag = false;
  //                       // });
  //                       Navigator.pop(context);
  //                     }),
  //               ],
  //             )
  //           ],
  //         );
  //       });
  // }

  _buildInstructions(String instructions) {
    var doc = parse(instructions);
    var elements = doc.getElementsByTagName('li');
    return ListView.builder(
        shrinkWrap: true,
        itemCount: elements.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Flexible(
              child: Text(
                '${index + 1}. ${elements[index].text}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ]));
        });
  }

  Widget _getRecipesList(String recipeID) {
    return FutureBuilder(
        future: rc.getRecipe(recipeID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: SingleChildScrollView(
                    child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(snapshot.data.title,
                        style: const TextStyle(
                            fontSize: 83.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w100,
                            color: Colors.black87))),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(snapshot.data.image),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(mainAxisSize: MainAxisSize.max, children: [
                          const Icon(Icons.group),
                          const SizedBox(width: 5),
                          Text("serves ${snapshot.data.servings.toString()}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300))
                        ]),

                        const SizedBox(height: 5),

                        Row(mainAxisSize: MainAxisSize.max, children: [
                          const Icon(Icons.watch_later_outlined),
                          const SizedBox(width: 5),
                          Text(
                              "${snapshot.data.readyInMinutes.toString()} minutes",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300))
                        ]),

                        // Text(snapshot.data.nutrients.toString()),
                      ]),
                ),
                const SizedBox(height: 20),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(color: kOrange, width: 3)),
                    child: Text("INGREDIENTS",
                        style: Theme.of(context).textTheme.headlineSmall)),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: <Widget>[
                    for (var ingredient in snapshot.data.ingredients)
                      ListTile(
                        leading: const Icon(Icons.fiber_manual_record),
                        title: Text(
                          ingredient,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(color: kOrange, width: 3)),
                    child: Text("INSTRUCTIONS",
                        style: Theme.of(context).textTheme.headlineSmall)),
                const SizedBox(height: 15),
                SizedBox(
                  width: 380,
                  child: Column(children: [
                    _buildInstructions(snapshot.data.instructions),
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(color: kOrange, width: 3)),
                    child: Text("NUTRIENTS",
                        style: Theme.of(context).textTheme.headlineSmall)),
                // snapshot.data.nutrients.forEach((n) {
                //   Text(n.toString() ?? "");
                // })
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      for (var nutrient in snapshot.data.nutrients)
                        ListTile(
                          visualDensity: const VisualDensity(
                              horizontal: 4, vertical: -4.0),

                          minLeadingWidth: 150,
                          leading: Text(nutrient["name"]),
                          // leading: Icon(Icons.fiber_manual_record),
                          title: Text(
                            "${nutrient["amount"]} ${nutrient["unit"]}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            )));
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Recipe Details',
                style: Theme.of(context).textTheme.titleLarge),
            actions: [
              IconButton(
                icon: Icon(
                  widget.addedTofav ? Icons.favorite : Icons.favorite_border,
                  color: widget.addedTofav ? Colors.red[700] : null,
                  size: 30,
                ),
                onPressed: () {
                  if (!widget.addedTofav) {
                    _addFavConfirmation(context);
                  }
                },
              )
            ]),
        body: _getRecipesList(widget.recipeID.toString()));
  }
}
