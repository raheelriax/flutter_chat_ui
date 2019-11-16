import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedCategory = 0;
  final List<String> categories = ['Messages', 'Online', 'Group', 'Requests'];

  Widget _buildCategoryList(){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = index;
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Text(
              categories[index],
              style: TextStyle(
                  fontSize: 20,
                  color: index == selectedCategory
                      ? Colors.white
                      : Colors.white60,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Theme.of(context).primaryColor,
      child: _buildCategoryList(),
    );
  }
}
