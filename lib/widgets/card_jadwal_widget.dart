part of 'widget.dart';

class JadwalCardWidget extends StatefulWidget {
  const JadwalCardWidget({Key? key}) : super(key: key);

  @override
  State<JadwalCardWidget> createState() => _JadwalCardWidgetState();
}

class _JadwalCardWidgetState extends State<JadwalCardWidget> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  String _dateFormatter(String _timestamp) {
    String formattedDate = DateFormat('dd').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _dateDayFormatter(String _timestamp) {
    String formattedDate = DateFormat.E().format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _dateMonthFormatter(String _timestamp) {
    String formattedDate = DateFormat.MMM().format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _timeFormatter(String _timestamp) {
    String formattedTime = DateFormat('kk:mm').format(DateTime.parse(_timestamp));
    return formattedTime;
  }

  Future<void> deleteBooking(String docID) async {
    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
      // await myTransaction.delete(snapshot.data.documents[index].reference);
    });
    return FirebaseFirestore.instance.collection('appointments').doc(user!.email.toString()).collection('pending').doc(docID).delete().then((_) => print('Deleted ' + docID)).catchError((error) => print('Delete failed: $error'));
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Konfirmasi Hapus"),
      content: Text("Yakin ingin menghapus?", style: fontTheme.subtitle1),
      actions: [
        TextButton(
          child: Text("Tidak"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Ya"),
          onPressed: () {
            print("hapus id " + _documentID!);
            deleteBooking(_documentID!);
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _checkDiff(DateTime _date) {
    var diff = DateTime.now().difference(_date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String _date) {
    if (_dateFormatter(DateTime.now().toString()).compareTo(_dateFormatter(_date)) == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('booking').doc(user!.email.toString()).collection('pending').orderBy('startTime').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.size == 0
              ? Center(
                  child: Text(
                    'Belum membuat jadwal',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    // if (_checkDiff(document['startTime'].toDate())) {
                    //   deleteBooking(document.id);
                    // }
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: greyColor.withOpacity(0.8), blurRadius: 8, offset: Offset(0, 3), spreadRadius: 2),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CachedNetworkImage(
                                  imageUrl: document['psikiaterImage'],
                                  fit: BoxFit.cover,
                                  height: 75,
                                  width: 75,
                                  placeholder: (context, url) => const CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    radius: 5,
                                  ),
                                  imageBuilder: (context, image) => CircleAvatar(
                                    backgroundImage: image,
                                    radius: 5,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(document['psikiaterName'], style: Theme.of(context).textTheme.bodyText1),
                                                      Text(document['psikiaterSpesialist'], style: Theme.of(context).textTheme.bodyText2),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 4),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.access_time,
                                                              size: 16,
                                                              color: greyColor,
                                                            ),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                  text: _timeFormatter(
                                                                    document['startTime'].toDate().toString(),
                                                                  ),
                                                                  style: fontTheme.bodyText2?.copyWith(
                                                                    color: greyColor,
                                                                    fontSize: 11,
                                                                  ),
                                                                  children: <TextSpan>[
                                                                    TextSpan(text: ' - '),
                                                                    TextSpan(
                                                                      text: _timeFormatter(
                                                                        document['endTime'].toDate().toString(),
                                                                      ),
                                                                      style: fontTheme.bodyText2?.copyWith(
                                                                        color: greyColor,
                                                                        fontSize: 11,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 3.0),
                                                child: Card(
                                                  color: Colors.blue,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          _dateDayFormatter(document['startTime'].toDate().toString()),
                                                          style: fontTheme.bodyText2?.copyWith(
                                                            color: whiteColor,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                              text: _dateFormatter(
                                                                document['startTime'].toDate().toString(),
                                                              ),
                                                              style: fontTheme.bodyText2?.copyWith(
                                                                color: whiteColor,
                                                                fontSize: 12,
                                                              ),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                  text: _dateMonthFormatter(
                                                                    document['startTime'].toDate().toString(),
                                                                  ),
                                                                  style: fontTheme.bodyText2?.copyWith(
                                                                    color: whiteColor,
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 25,
                                                    child: Icon(Icons.info, color: greyColor),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'Pembatalan tersedia 30 menit sebelum konsultasi',
                                                      style: fontTheme.bodyText2?.copyWith(
                                                        color: greyColor,
                                                        fontSize: 8,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: redAlertColor,
                                              borderRadius: BorderRadius.circular(18),
                                              border: Border.all(
                                                color: redAlertboderColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 25,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    AlertDialog alert = AlertDialog(
                                                      title: Text("Konfirmasi Hapus"),
                                                      content: Text("Yakin ingin menghapus?", style: fontTheme.subtitle1),
                                                      actions: [
                                                        TextButton(
                                                          child: Text("Tidak"),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text("Ya"),
                                                          onPressed: () async {
                                                            _documentID = document.id;
                                                            print("hapus id " + _documentID!);
                                                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                              await myTransaction.delete(snapshot.data!.docs[index].reference);
                                                            });
                                                            deleteBooking(_documentID!);
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return alert;
                                                      },
                                                    );
                                                    // print(">>>>>>>>>" + document.id);
                                                    // _documentID = document.id;
                                                    // showAlertDialog(context);
                                                  },
                                                  child: Text(
                                                    'Batalkan',
                                                    style: TextStyle(fontSize: 11, color: whiteColor),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(redAlertboderColor),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: whiteColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    final url = document['link'];
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: Text(
                                                    'Buka Meet',
                                                    style: TextStyle(fontSize: 11, color: whiteColor),
                                                  ),
                                                  style: ButtonStyle(
                                                    // backgroundColor: MaterialStateProperty.all<Color>(accentColor),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: whiteColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        });
  }
}
