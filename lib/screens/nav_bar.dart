import 'package:flutter/material.dart';

import 'package:food_waste/screens/profile.dart';
import 'package:food_waste/screens/rewards.dart';
import 'package:food_waste/screens/scoreboard.dart';

class NavBar extends StatefulWidget {
  static const routeName = '/navBar';
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var selectedIndex = 2;
  var leaderBoardSelected = false;
  var cakeSelected = false;
  var profileSelected = true;
  var settingsSelected = false;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      leaderBoardSelected = selectedIndex == 0;
      cakeSelected = selectedIndex == 1;
      settingsSelected = selectedIndex == 02;
    });
  }

  Widget selectPage() {
    if (leaderBoardSelected) {
      return ScoreBoard();
    } else if (cakeSelected) {
      return RewardsPage();
    } else if (settingsSelected) {
      return Profile();
    }
    return Profile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: selectPage(),
      bottomNavigationBar: buildNavBar(context),
    );
  }

  Widget buildNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).accentColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.format_list_numbered,
            size: 50.0,
            color: leaderBoardSelected
                ? Theme.of(context).focusColor
                : Colors.black,
          ),
          title: Text('LeaderBoards'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.cake,
            size: 50.0,
            color: cakeSelected ? Theme.of(context).focusColor : Colors.black,
          ),
          title: Text('Rewards'),
        ),
        BottomNavigationBarItem(
          icon:
              Icon(
            Icons.person,
            size: 50.0,
            color:
                settingsSelected ? Theme.of(context).focusColor : Colors.black,
          ),
          title: Text('User Profile'),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).focusColor,
      onTap: _onItemTapped,
    );
  }
}
