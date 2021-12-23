part of 'ui.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/list_psikiater';
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController _psikiaterController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Icon _searchIcon = const Icon(Icons.search);
  Icon _user_md = const Icon(Plus.userMd);
  Widget _appBar = Text(
    'List Psikiater',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _psikiaterController = TextEditingController();
  }

  @override
  void dispose() {
    _psikiaterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: _appBar,
        leading: Icon(Plus.userMd),
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
          _appBar = TextFormField(
            controller: _psikiaterController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Cari nama Psikiater',
            ),
            onChanged: (query) => {
              if (query != '')
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchList(
                        searchKey: query,
                      ),
                    ),
                  ),
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
          _psikiaterController.clear();
        }
      },
    );
  }
}
