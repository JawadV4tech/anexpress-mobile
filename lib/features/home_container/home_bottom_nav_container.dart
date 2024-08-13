// import 'package:anexpress/exports/core_export.dart';
// import 'package:anexpress/features/home_screen/home_screen.dart';
// import 'package:anexpress/features/home_sidebar_menu_screen/home_sidebar_menu_screen.dart';
// import 'package:anexpress/widgets/custom_bottom_bar.dart';

// import 'package:flutter/material.dart';

// // ignore_for_file: must_be_immutable
// class HomeBottomNavContainer extends StatefulWidget {
//   final bool showWelcome;

//   const HomeBottomNavContainer({super.key, this.showWelcome = false});

//   @override
//   State<HomeBottomNavContainer> createState() => _HomeBottomNavContainerState();
// }

// class _HomeBottomNavContainerState extends State<HomeBottomNavContainer> {
//   GlobalKey<NavigatorState> navigatorKey = GlobalKey();

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   void openDrawer() {
//     _scaffoldKey.currentState?.openDrawer();
//   }

//   @override
//   void initState() {
//     super.initState();

//     // _timer();
//   }

//   /// Set timer splash
//   _timer() async {
//     //return Timer(const Duration(milliseconds: 2300), showWelcomePopUp);
//   }

//   @override
//   Widget build(BuildContext context) {
//     setStatusBarTheme();
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: Drawer(child: HomeSidebarMenuScreen()),
//         body: Navigator(
//           key: navigatorKey,
//           initialRoute: AppRoutes.mainHomePage,
//           onGenerateRoute: (routeSetting) => PageRouteBuilder(
//             pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
//             transitionDuration: const Duration(seconds: 0),
//           ),
//         ),
//         bottomNavigationBar: CustomBottomBar(
//           onChanged: (BottomBarEnum type) {
//             Navigator.pushNamed(
//               navigatorKey.currentContext!,
//               getCurrentRoute(type),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   ///Handling route based on bottom click actions
//   String getCurrentRoute(BottomBarEnum type) {
//     switch (type) {
//       case BottomBarEnum.Home:
//         return AppRoutes.mainHomePage;
//       case BottomBarEnum.Cards:
//         return AppRoutes.cardsScreen;
//       case BottomBarEnum.Transactions:
//         return AppRoutes.transactionsScreen;
//       default:
//         return "/";
//     }
//   }

//   ///Handling page based on route
//   Widget getCurrentPage(String currentRoute) {
//     switch (currentRoute) {
//       case AppRoutes.mainHomePage:
//         return HomeScreen();
//       case AppRoutes.cardsScreen:
//         //return CardsScreen(openDrawer: openDrawer);
//         return const DefaultWidget(
//           title: "Cards Widget",
//         );
//       case AppRoutes.transactionsScreen:
//         //return TransactionsScreen(openDrawer: openDrawer);
//         return const DefaultWidget(title: "Transactions Widget");
//       default:
//         return const DefaultWidget(title: "Default Widget");
//     }
//   }
// }
