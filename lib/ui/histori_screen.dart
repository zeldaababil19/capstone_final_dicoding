part of 'ui.dart';

class HistoriScreens extends StatefulWidget {
  static const routeName = '/histori_screen';

  const HistoriScreens({Key? key}) : super(key: key);

  @override
  _HistoriScreensState createState() => _HistoriScreensState();
}

class _HistoriScreensState extends State<HistoriScreens> {
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = const Icon(Icons.search);
  Icon calendar = const Icon(Plus.history);
  Widget _appBar = Text(
    'History',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBar,
        leading: calendar,
        // actions: <Widget>[
        //   IconButton(
        //     icon: _searchIcon,
        //     iconSize: 30,
        //     onPressed: _search,
        //   ),
        // ],
        // actions: <Widget>[],
      ),
      body: Container(
        color: baseColor,
        child: ListView(
          children: [
            HistoriCardWidget(),
          ],
        ),
      ),
    );
  }

  // void _search() {
  //   setState(
  //     () {
  //       if (_searchIcon.icon == Icons.search) {
  //         _searchIcon = Icon(Icons.close);
  //         _appBar = TextField(
  //           controller: _filter,
  //           cursorColor: Colors.white,
  //           decoration: InputDecoration(hintText: 'Cari nama Psikiater'),
  //           onChanged: (query) => {
  //             if (query != '')
  //               {
  //                 // provider.getRestaurantSearch(query),
  //               }
  //           },
  //         );
  //       } else {
  //         this._searchIcon = Icon(Icons.search);
  //         this._appBar = Text(
  //           'List Psikiater',
  //           style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  //         );
  //         // provider.getAllRestaurants();
  //         _filter.clear();
  //       }
  //     },
  //   );
  // }

}
