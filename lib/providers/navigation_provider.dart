part of 'provider.dart';

class NavigationProvider extends ChangeNotifier {
  int _index = 0;
  PageController _page = PageController(initialPage: 0);

  int get index => _index;
  PageController get page => _page;

  void changeIndex(int index, {int initialPage = 0}) {
    _index = index;
    _page.jumpToPage(index);
    _page = PageController(initialPage: initialPage);

    notifyListeners();
  }
}
