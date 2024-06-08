import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/utils/appStyles.dart';
import 'EnterStudInfo.dart'; // Assuming EnterStudInfo.dart contains the EnterStudInfo widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _enterStudButton(() => null, "Enter New"),
                Row(
                  children: [_actionButton(() => null, Icons.upload)],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _seeAllStudentsButton(() => null, "See All Students"),
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _enterStudButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EnterStudInfo()),
        );
      },
      style: _buttonstyle(),
      child: Text(text),
    );
  }

  ElevatedButton _seeAllStudentsButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EnterStudInfo()),
        );
      },
      style: _buttonstyle(),
      child: Text(text),
    );
  }

  IconButton _actionButton(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      splashColor: AppTheme.splcolor,
      icon: Icon(
        icon,
        color: AppTheme.iconcolor,
      ),
    );
  }

  ButtonStyle _buttonstyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.testcol,
      foregroundColor: AppTheme.blackcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
      ),
    );
  }
}
