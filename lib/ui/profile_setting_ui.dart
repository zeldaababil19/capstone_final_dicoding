part of 'ui.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSetting> {
  // UserProfileDetails detail = UserProfileDetails();

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  List labelName = [
    'Photo',
    'Name',
    'Email',
    'Jenis Kelamin',
    'Nomor HandPhone',
    'Tanggal Lahir',
    'address',
  ];

  List value = [
    'image',
    'name',
    'email',
    'gender',
    'phone',
    'birthDate',
    'address',
  ];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference pasiens = FirebaseFirestore.instance.collection('pasiens');

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: baseColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'Profile Settings',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: pasiens.doc(user!.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      6,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: InkWell(
                          splashColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateProfile(
                                          label: labelName[index],
                                          field: value[index],
                                        )));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              height: MediaQuery.of(context).size.height / 14,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    labelName[index],
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data[value[index]]?.isEmpty ?? true ? 'belum ada' : data[value[index]],
                                    style: GoogleFonts.lato(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    accentColor,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
