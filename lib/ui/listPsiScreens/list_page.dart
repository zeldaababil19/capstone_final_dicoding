part of '../ui.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/home_page';
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = const Icon(Icons.search);
  Icon _user_md = const Icon(Plus.user_md);
  Widget _appBar = Text(
    'List Psikiater',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBar,
        leading: Icon(Plus.user_md),
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            iconSize: 30,
            onPressed: _search,
          ),
        ],
        // actions: <Widget>[],
      ),
      body: Container(
        color: baseColor,
        child: ListView(
          children: [
            PsikiaterCardWidget(),
          ],
        ),
      ),
    );
  }

  void _search() {
    setState(
      () {
        if (_searchIcon.icon == Icons.search) {
          _searchIcon = Icon(Icons.close);
          _appBar = TextField(
            controller: _filter,
            cursorColor: Colors.white,
            decoration: InputDecoration(hintText: 'Cari nama Psikiater'),
            onChanged: (query) => {
              if (query != '')
                {
                  // provider.getRestaurantSearch(query),
                }
            },
          );
        } else {
          this._searchIcon = Icon(Icons.search);
          this._appBar = Text(
            'List Psikiater',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
          );
          // provider.getAllRestaurants();
          _filter.clear();
        }
      },
    );
  }
}