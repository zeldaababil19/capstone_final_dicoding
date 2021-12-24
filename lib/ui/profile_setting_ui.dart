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
    'Name',
    'Email',
    'Jenis Kelamin',
    'Nomor HandPhone',
    'Tanggal Lahir',
    'address',
  ];

  List value = [
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

  File? _imageFile = null;

  final picker = ImagePicker();

  Future pickImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = p.basename(_imageFile!.path);
    Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('uploads').child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(contentType: 'image/jpeg', customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(File(_imageFile!.path), metadata);

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {print("Upload file path ${value.ref.fullPath}")}).onError((error, stackTrace) => {print("Upload file path error ${error.toString()} ")});
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference pasiens = FirebaseFirestore.instance.collection('pasiens');

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
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
      body: Container(
        color: baseColor,
        child: Column(
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

                  return Column(
                    children: [
                      // Stack(children: [
                      //   Container(
                      //     child: Column(
                      //       children: [
                      //         user!.photoURL != null
                      //             ? ClipOval(
                      //                 child: Material(
                      //                   color: Colors.blue,
                      //                   child: Image.network(
                      //                     user!.photoURL!,
                      //                     fit: BoxFit.fitHeight,
                      //                   ),
                      //                 ),
                      //               )
                      //             : ClipOval(
                      //                 child: Material(
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.all(26.0),
                      //                     child: Icon(
                      //                       Icons.person,
                      //                       size: 90,
                      //                       color: Colors.blue,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //       ],
                      //     ),
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: Colors.blue,
                      //           width: 5,
                      //         ),
                      //         shape: BoxShape.circle),
                      //   ),
                      //   Container(
                      //     child: IconButton(
                      //       onPressed: () {
                      //         pickImage;
                      //       },
                      //       icon: FaIcon(
                      //         FontAwesomeIcons.cog,
                      //         color: blackColor,
                      //         size: 30,
                      //       ),
                      //     ),
                      //   ),
                      // ]),
                      // ElevatedButton(
                      //   onPressed: () => uploadImageToFirebase(context),
                      //   child: Text(
                      //     "Upload Image",
                      //     style: TextStyle(fontSize: 20, color: Colors.white),
                      //   ),
                      // ),
                      ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: List.generate(
                          6,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                              child: Container(
                                height: MediaQuery.of(context).size.height / 14,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(color: greyColor.withOpacity(0.8), blurRadius: 8, offset: Offset(0, 3), spreadRadius: 2),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        labelName[index],
                                        style: fontTheme.subtitle2!.copyWith(
                                          color: blackColor,
                                        ),
                                      ),
                                      Text(
                                        data[value[index]]?.isEmpty ?? true ? 'belum ada' : data[value[index]],
                                        style: fontTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
