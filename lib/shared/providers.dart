part of 'shared.dart';

List<SingleChildWidget> appProvider = [
  ChangeNotifierProvider(create: (_) => NavigationProvider()),
  // ChangeNotifierProvider(create: (_) => UserProvider(user: user)),
];
