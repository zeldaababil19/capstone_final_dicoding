part of 'widget.dart';

class UpdateProfile extends StatefulWidget {
  final String label;
  final String field;
  const UpdateProfile({Key? key, required this.label, required this.field}) : super(key: key);

  @override
  _UpdateProfile createState() => _UpdateProfile();
}

class _UpdateProfile extends State<UpdateProfile> {
  final TextEditingController _textController = TextEditingController();
  FocusNode f1 = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late String userID;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
    userID = user.uid;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('pasiens').doc(userID).snapshots(),
              builder: (context, snapshot) {
                return SizedBox(
                  child: TextFormField(
                    focusNode: f1,
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: fontTheme.bodyText1,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[350],
                        hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                    onFieldSubmitted: (String value) {
                      _textController.text = value;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                  updateData();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Colors.blue.withOpacity(0.9),
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                  'Update',
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    FirebaseFirestore.instance.collection('pasiens').doc(userID).set({
      widget.field: _textController.text,
    }, SetOptions(merge: true));
    if (widget.field.compareTo('name') == 0) {
      // ignore: deprecated_member_use
      await user.updateProfile(displayName: _textController.text);
    }
    if (widget.field.compareTo('phone') == 0) {}
  }
}
