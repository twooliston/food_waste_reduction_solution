import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/accountDetails.dart';
import 'screens/contact.dart';
import 'screens/notifications.dart';
import 'screens/user_product_details.dart';
import 'screens/edit_product_screen.dart';
import 'screens/login.dart';
import 'screens/splash.dart';
import 'screens/product_overview.dart';
import 'screens/product_details.dart';
import 'screens/nav_bar.dart';
import 'screens/profile.dart';
import 'screens/intro1.dart';
import 'screens/intro2.dart';
import 'screens/intro3.dart';
import 'screens/settings.dart';

import 'providers/products_provider.dart';
import 'providers/accounts_provider.dart';
import 'providers/rewards_provider.dart';
import 'providers/orders_provider.dart';
import 'providers/auth.dart';

// run the app
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Rewards()),
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Accounts>(
          create: (_) => null,
          update: (
            ctx,
            auth,
            previousAccounts,
          ) =>
              Accounts(
            auth.token,
            auth.userId,
            previousAccounts == null ? [] : previousAccounts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => null,
          update: (
            ctx,
            auth,
            previousProducts,
          ) =>
              Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => null,
          update: (
            ctx,
            auth,
            previousOrders,
          ) =>
              Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xFFF4FFDE),
            accentColor: Color(0xFFD3E8B5),
            focusColor: Color(0xFFDD7777),
            fontFamily: '',
          ),
          home: auth.isAuth
              ? OverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : Intro1(),
                          // : Login(),
                ),
          routes: {
            Intro2.routeName: (ctx) => Intro2(),
            Intro3.routeName: (ctx) => Intro3(),
            OverviewScreen.routeName: (ctx) => OverviewScreen(),
            ProductDetails.routeName: (ctx) => ProductDetails(),
            UserProductDetails.routeName: (ctx) => UserProductDetails(),
            EditProductDetails.routeName: (ctx) => EditProductDetails(),
            Profile.routeName: (ctx) => Profile(),
            NavBar.routeName: (ctx) => NavBar(),
            Settings.routeName: (ctx) => Settings(),
            AccountDetails.routeName: (ctx) => AccountDetails(),
            Notifications.routeName: (ctx) => Notifications(),
            Contact.routeName: (ctx) => Contact(),
            Login.routeName: (ctx) => Login(),
          },
        ),
      ),
    );
  }
}
