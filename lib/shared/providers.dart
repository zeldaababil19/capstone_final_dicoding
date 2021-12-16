part of 'shared.dart';

List<SingleChildWidget> appProvider = [
  ChangeNotifierProvider(create: (_) => NavigationProvider()),
  // ChangeNotifierProvider(create: (_) => ListPage()),
  // ChangeNotifierProvider(create: (_) => JadwalScreens()),
  // ChangeNotifierProvider(create: (_) => HistoryScreen()),
  // ChangeNotifierProvider(create: (_) => UserProvider()),
];
