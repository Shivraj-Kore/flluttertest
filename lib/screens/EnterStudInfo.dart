import 'package:flutter/material.dart';
import 'package:schoolapp/utils/appStyles.dart';
import 'package:mysql1/mysql1.dart';

class EnterStudInfo extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _classNumberController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _rollNumberFocusNode = FocusNode();
  final FocusNode _classNumberFocusNode = FocusNode();
  final FocusNode _divisionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.dark,
        foregroundColor: Colors.white,
        title: Text('Enter Student Info'),
      ),
      backgroundColor: AppTheme.dark,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildTextField(
                      _nameController, _nameFocusNode, 'Enter Name'),
                  _buildTextField(_rollNumberController, _rollNumberFocusNode,
                      'Enter Roll Number'),
                  _buildTextField(_classNumberController, _classNumberFocusNode,
                      'Enter Class Number'),
                  _buildTextField(_divisionController, _divisionFocusNode,
                      'Enter Division'),
                ],
              ),
              SizedBox(height: 20),
              _submitButton(() async {
                await _submitData(context);
              }, "Submit"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, FocusNode focusNode, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: Colors.pink, // Change the cursor color here
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  ElevatedButton _submitButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.testcol,
      foregroundColor: AppTheme.blackcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
      ),
    );
  }

  Future<void> _submitData(BuildContext context) async {
    var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'test',
    );

    try {
      var conn = await MySqlConnection.connect(settings);

      // Log the values of the text controllers
      print('Roll Number: ${_rollNumberController.text}');
      print('Name: ${_nameController.text}');
      print('Class Number: ${_classNumberController.text}');
      print('Division: ${_divisionController.text}');

      // Insert the data into the database
      var result = await conn.query(
        'INSERT INTO students (rollno, studname , class, division) VALUES (?, ?, ?, ?)',
        [
          _rollNumberController.text,
          _nameController.text,
          _classNumberController.text,
          _divisionController.text,
        ],
      );

      print('Inserted row id=${result.insertId}');
      await conn.close();
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
