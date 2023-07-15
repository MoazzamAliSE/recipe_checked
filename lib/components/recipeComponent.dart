import 'package:flutter/material.dart';
import 'package:recipe_checked/pages/recipedetails.dart';
import 'package:recipe_checked/utils/constants.dart';

class RecipeComponent extends StatefulWidget {
  int recipeID;
  String recipeName;
  bool addedToFav;

  RecipeComponent({
    super.key,
    required this.recipeID,
    required this.recipeName,
    this.addedToFav = false,
  });

  @override
  _RecipeComponentState createState() => _RecipeComponentState();
}

class _RecipeComponentState extends State<RecipeComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
      child: Material(
        //Wrap with Material
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
        elevation: 18.0,
        color: kOrange,
        clipBehavior: Clip.antiAlias, // Add This
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipeDetails(
                        recipeID: widget.recipeID,
                        recipeName: widget.recipeName,
                        addedTofav: widget.addedToFav,
                      )),
            );
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.recipeName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
