part of 'ui.dart';

class BookingScreen extends StatefulWidget {
  final String psikiaterName;
  final String psikiaterEmail;
  final String psikiaterSpesialist;
  final String psikiaterImage;

  const BookingScreen({
    Key? key,
    required this.psikiaterName,
    required this.psikiaterEmail,
    required this.psikiaterSpesialist,
    required this.psikiaterImage,
  }) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  CalendarClient calendarClient = CalendarClient();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController textControllerDate;
  late TextEditingController textControllerStartTime;
  late TextEditingController textControllerEndTime;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  static const _scopes = [calendar.CalendarApi.calendarScope];

  late String currentTitle = 'Halo Psikiater ';
  late String currentDesc = 'Konsultasi dengan pasien ' + user!.displayName!;
  late String psikiaterEmail = widget.psikiaterEmail;
  late String psikiaterName = widget.psikiaterName;
  late String psikiaterSpesialist = widget.psikiaterSpesialist;
  late String psikiaterImage = widget.psikiaterImage;
  late String pasienEmail = user!.email!;
  late String pasienName = user!.displayName!;
  late String errorString = '';
  List<calendar.EventAttendee> attendeeEmails = [];
  // var fixedLengthList = List<String>.filled(1, '${psikiaterEmail}');
  // var attendeeEmails = List.filled(1, []) as List<calendar.EventAttendee>;
  // var shared = List.filled(3, []);

  bool isEditingDate = false;
  bool isEditingStartTime = false;
  bool isEditingEndTime = false;
  bool isEditingEmail = false;
  bool isEditingLink = false;
  bool isErrorTime = false;
  bool shouldNofityAttendees = true;
  bool hasConferenceSupport = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  void initState() {
    super.initState();
    calendar.EventAttendee eventAttendee = calendar.EventAttendee();
    eventAttendee.email = psikiaterEmail;
    attendeeEmails.add(eventAttendee);
    _getUser();
    textControllerDate = TextEditingController();
    textControllerStartTime = TextEditingController();
    textControllerEndTime = TextEditingController();

    // attendeeEmails[0].add(psikiaterEmail);

//ini yang masalah
    // calendar.EventAttendee eventAttendee = new calendar.EventAttendee();
    // eventAttendee.email = psikiaterEmail;
    // attendeeEmails.add(eventAttendee);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textControllerDate.text = DateFormat.yMMMMd().format(selectedDate);
      });
    }
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    } else {
      setState(() {
        textControllerStartTime.text = selectedStartTime.format(context);
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    } else {
      setState(() {
        textControllerEndTime.text = selectedEndTime.format(context);
      });
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Selesai!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Berhasil membuat jadwal",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Pilih Jadwal',
          style: fontTheme.headline6,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('psikiaters').orderBy('name').startAt([widget.psikiaterName]).endAt([widget.psikiaterName + '\uf8ff']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl: document['image'],
                            fit: BoxFit.cover,
                            height: 95,
                            width: 95,
                            imageBuilder: (context, image) => CircleAvatar(
                              backgroundImage: image,
                              radius: 5,
                            ),
                          ),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ]),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(document['name'],
                                  style: fontTheme.subtitle1?.copyWith(
                                    color: blackColor,
                                  )),
                              Text(document['spesialis'], style: fontTheme.bodyText2),
                              Row(children: [
                                Icon(
                                  Icons.business_center,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  document['experience'],
                                  style: fontTheme.bodyText2?.copyWith(
                                    // color: darkGreyColor,
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                              Row(children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  document['rating'].toString(),
                                  style: fontTheme.bodyText2?.copyWith(
                                    // color: darkGreyColor,
                                    fontSize: 12,
                                  ),
                                )
                              ])
                            ]),
                          ),
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: 250,
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
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: accentColor,
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(
                                  'Detail Booking',
                                  style: fontTheme.subtitle1?.copyWith(
                                    color: blackColor,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Tanggal',
                                  style: fontTheme.subtitle1?.copyWith(
                                    color: blackColor,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextFormField(
                                        controller: textControllerDate,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[350],
                                          hintText: 'Select Date*',
                                          hintStyle: GoogleFonts.lato(
                                            color: Colors.black26,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        // controller: textControllerDate,
                                        validator: (value) {
                                          if (value!.isEmpty) return 'Please Enter the Date';
                                          return null;
                                        },
                                        // onFieldSubmitted: (String value) {
                                        //   f1.unfocus();
                                        //   FocusScope.of(context).requestFocus(f2);
                                        // },
                                        textInputAction: TextInputAction.next,
                                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5.0),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.indigo, // button color
                                            child: InkWell(
                                              // inkwell color
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.date_range_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () {
                                                _selectDate(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextFormField(
                                        controller: textControllerStartTime,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[350],
                                          hintText: 'Select Start Time*',
                                          hintStyle: GoogleFonts.lato(
                                            color: Colors.black26,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) return 'Please Enter the Time';
                                          return null;
                                        },
                                        // onFieldSubmitted: (String value) {
                                        //   f2.unfocus();
                                        // },
                                        textInputAction: TextInputAction.next,
                                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5.0),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.indigo, // button color
                                            child: InkWell(
                                              // inkwell color
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.timer_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () {
                                                _selectStartTime(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextFormField(
                                        controller: textControllerEndTime,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[350],
                                          hintText: 'Select End Time*',
                                          hintStyle: GoogleFonts.lato(
                                            color: Colors.black26,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) return 'Please Enter the Time';
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5.0),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.indigo, // button color
                                            child: InkWell(
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.timer_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () {
                                                _selectEndTime(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 2,
                                        primary: Colors.indigo,
                                        onPrimary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          int startTimeInEpoch = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedStartTime.hour,
                                            selectedStartTime.minute,
                                          ).millisecondsSinceEpoch;

                                          int endTimeInEpoch = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedEndTime.hour,
                                            selectedEndTime.minute,
                                          ).millisecondsSinceEpoch;

                                          print(attendeeEmails);
                                          print('DIFFERENCE: ${endTimeInEpoch - startTimeInEpoch}');

                                          print('Start Time: ${DateTime.fromMillisecondsSinceEpoch(startTimeInEpoch)}');
                                          print('End Time: ${DateTime.fromMillisecondsSinceEpoch(endTimeInEpoch)}');

                                          if (endTimeInEpoch - startTimeInEpoch > 0) {
                                            print('endtimepoech');

                                            // if (_validateTitle(currentTitle) == null) {
                                            await calendarClient.insert(
                                              currentTitle: currentTitle,
                                              currentDesc: currentDesc,
                                              psikiaterName: psikiaterName,
                                              pasienName: user!.displayName!,
                                              psikiaterSpesialist: psikiaterSpesialist,
                                              psikiaterImage: psikiaterImage,
                                              attendeeEmailList: attendeeEmails,
                                              shouldNotifyAttendees: shouldNofityAttendees,
                                              hasConferenceSupport: hasConferenceSupport,
                                              startTime: DateTime.fromMillisecondsSinceEpoch(startTimeInEpoch),
                                              endTime: DateTime.fromMillisecondsSinceEpoch(endTimeInEpoch),
                                            );
                                          } else {
                                            setState(() {
                                              isErrorTime = true;
                                              errorString = 'Kesalahan pemilihan waktu';
                                            });
                                          }

                                          /// aktifkan ini jika tidak bisa booking
                                          // await calendarClient.insert(
                                          //   currentTitle: currentTitle,
                                          //   currentDesc: currentDesc,
                                          //   psikiaterName: psikiaterName,
                                          //   pasienName: user!.displayName!,
                                          //   psikiaterSpesialist: psikiaterSpesialist,
                                          //   psikiaterImage: psikiaterImage,
                                          //   attendeeEmailList: attendeeEmails,
                                          //   shouldNotifyAttendees: shouldNofityAttendees,
                                          //   hasConferenceSupport: hasConferenceSupport,
                                          //   startTime: DateTime.fromMillisecondsSinceEpoch(startTimeInEpoch),
                                          //   endTime: DateTime.fromMillisecondsSinceEpoch(endTimeInEpoch),
                                          // );
                                          print(textControllerDate.text);
                                          print(textControllerStartTime.text);
                                          print(textControllerEndTime.text);
                                          print(widget.psikiaterName);
                                          print(user!.displayName);
                                          showAlertDialog(context);
                                        }
                                      },
                                      child: Text(
                                        "Booking Jadwal",
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      )
                    ]),
                  );
                },
              );
            }),
      ),
    );
  }
}
