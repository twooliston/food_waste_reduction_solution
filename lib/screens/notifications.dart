import 'package:flutter/material.dart';
import 'package:food_waste/generic_widgets/back.dart';
import 'package:food_waste/generic_widgets/text.dart';

class Notifications extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isNotification = true;

  void _onItemTapped(bool state) {
    setState(() {
      isNotification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 35.0,
        bottom: 60.0,
      ),
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              BuildBackArrow(context),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: BuildText('notification settings', null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      padding: EdgeInsets.only(
        left: 75.0,
        right: 75.0,
        top: 50.0,
        bottom: 20.0,
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => _onItemTapped(true),
            child: _notificationItem(_notificationIcon(), 'notifications on'),
          ),
          GestureDetector(
            onTap: () =>  _onItemTapped(false),
            child: _notificationItem(_noNotificationIcon(), 'notifications off'),
          ),
        ],
      ),
    );
  }

  Widget _notificationItem(Widget getIcon, String text) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        children: <Widget>[
          getIcon,
          Expanded(
            child: BuildText(text, null),
          ),
        ],
      ),
    );
  }

  Widget _notificationIcon() {
    return Icon(
      Icons.notifications,
      size: 50.0,
      color: isNotification ? Colors.black : Colors.black.withOpacity(0.2),
    );
  }

  Widget _noNotificationIcon() {
    return Icon(
      Icons.notifications_off,
      size: 50.0,
      color: !isNotification ? Colors.black : Colors.black.withOpacity(0.2),
    );
  }
}
