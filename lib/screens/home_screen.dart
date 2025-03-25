import 'package:flutter/material.dart';

import 'package:client_recipe_book_app/screens/recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _recipesCard(context),
          _recipesCard(context),
          _recipesCard(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottom(context);
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: ReciperForm(),
          ),
    );
  }

  Widget _recipesCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipeName: 'Lasagna'),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://static.platzi.com/media/uploads/flutter_lasana_b894f1aee1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Lasagna',
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 5),
                    Container(height: 2, width: 75, color: Colors.orange),
                    Text(
                      'Alison J',
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReciperForm extends StatelessWidget {
  const ReciperForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeNameController = TextEditingController();
    final TextEditingController _recipeAuthorController =
        TextEditingController();
    final TextEditingController _recipeImageUrlController =
        TextEditingController();
    final TextEditingController _recipeDescriptionController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add new recipe',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontFamily: 'Quicksand',
              ),
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeNameController,
              label: 'Recipe Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name recipe';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeAuthorController,
              label: 'Author',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the author';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeImageUrlController,
              label: 'Image URL',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the image url recipe';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeDescriptionController,
              label: 'Recipe Description',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description recipe';
                }
                return null;
              },
              maxLines: 4,
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: 'Quicksand', color: Colors.orange),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
