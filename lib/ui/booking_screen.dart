part of 'ui.dart';

class BookingScreen extends StatefulWidget {
  final String psikiater;

  const BookingScreen({Key? key, required this.psikiater}) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Storage storage = Storage();
  CalendarClient calendarClient = CalendarClient();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _psikiaterController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _attendeeController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();
  FocusNode f7 = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  String timeText = 'Pilih jam';
  late String dateUTC;
  late String date_Start_Time;
  late String date_End_Time;

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('dd-MM-yyyy').format(selectedDate);
          },
        );
      },
    );
  }

  // Future<void> selectTime(BuildContext context) async {
  //   TimeOfDay selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: currentTime,
  //   );

  //   MaterialLocalizations localizations = MaterialLocalizations.of(context);
  //   String formattedTime = localizations.formatTimeOfDay(selectedTime, alwaysUse24HourFormat: false);

  //   if (formattedTime != null) {
  //     setState(() {
  //       timeText = formattedTime;
  //       _timeController.text = timeText;
  //     });
  //   }
  //   date_Time = selectedTime.toString().substring(10, 15);
  // }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(picked!, alwaysUse24HourFormat: false);

    if (formattedTime != null) {
      setState(() {
        timeText = formattedTime;
        _timeStartController.text = timeText;
      });
    }
    date_Start_Time = picked.toString().substring(10, 15);
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(picked!, alwaysUse24HourFormat: false);

    if (formattedTime != null) {
      setState(() {
        timeText = formattedTime;
        _timeEndController.text = timeText;
      });
    }
    date_End_Time = picked.toString().substring(10, 15);
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: fontTheme.bodyText1!.copyWith(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyBooking(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Berhasil", style: fontTheme.bodyText1),
      content: Text(
        "Jadwal berhasil dibuat",
        style: fontTheme.bodyText1!.copyWith(color: Colors.grey),
      ),
      actions: [
        okButton,
      ],
      backgroundColor: baseColor,
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
  void initState() {
    super.initState();
    _getUser();
    _selectEndTime(context);
    _selectStartTime(context);
    _psikiaterController.text = widget.psikiater;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
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
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Detail Pasien', style: fontTheme.subtitle1),
                    ),
                    TextFormField(
                      controller: _nameController,
                      focusNode: f1,
                      validator: (value) {
                        if (value!.isEmpty) return 'Masukkan Nama Pasien';
                        return null;
                      },
                      style: fontTheme.bodyText1,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Nama Pasien',
                          hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                      onFieldSubmitted: (String value) {
                        f1.unfocus();
                        FocusScope.of(context).requestFocus(f2);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: f2,
                      controller: _phoneController,
                      style: fontTheme.bodyText1,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Nomor Hp',
                          hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Masukkan Nomor Hp';
                        } else if (value.length < 10) {
                          return 'Masukkan Nomor Hp dengan benar';
                        }
                        return null;
                      },
                      onFieldSubmitted: (String value) {
                        f2.unfocus();
                        FocusScope.of(context).requestFocus(f3);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      focusNode: f3,
                      controller: _descriptionController,
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
                          hintText: 'Deskripsi',
                          hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                      onFieldSubmitted: (String value) {
                        f3.unfocus();
                        FocusScope.of(context).requestFocus(f4);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      controller: _psikiaterController,
                      validator: (value) {
                        if (value!.isEmpty) return 'Masukkan Nama Psikiater';
                        return null;
                      },
                      style: fontTheme.bodyText1,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'Nama Psikiater',
                          hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                    ),
                    SizedBox(height: 6),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            focusNode: f4,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[350],
                                hintText: 'Pilih tanggal',
                                hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                            controller: _dateController,
                            validator: (value) {
                              if (value!.isEmpty) return 'Masukkan tanggal';
                              return null;
                            },
                            onFieldSubmitted: (String value) {
                              f4.unfocus();
                              FocusScope.of(context).requestFocus(f5);
                            },
                            textInputAction: TextInputAction.next,
                            style: fontTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ClipOval(
                              child: Material(
                                color: Colors.blue, // button color
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
                                    selectDate(context);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            focusNode: f5,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[350],
                                hintText: 'Pilih jam awal',
                                hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                            controller: _timeStartController,
                            validator: (value) {
                              if (value!.isEmpty) return 'Pilih jam awal';
                              return null;
                            },
                            onFieldSubmitted: (String value) {
                              f5.unfocus();
                              FocusScope.of(context).requestFocus(f6);
                            },
                            textInputAction: TextInputAction.next,
                            style: fontTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ClipOval(
                              child: Material(
                                color: Colors.blue, // button color
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
                      height: 6,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            focusNode: f6,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[350],
                                hintText: 'Pilih jam akhir',
                                hintStyle: fontTheme.bodyText1!.copyWith(color: Colors.grey)),
                            controller: _timeEndController,
                            validator: (value) {
                              if (value!.isEmpty) return 'Pilih jam akhir';
                              return null;
                            },
                            onFieldSubmitted: (String value) {
                              f6.unfocus();
                            },
                            textInputAction: TextInputAction.next,
                            style: fontTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ClipOval(
                              child: Material(
                                color: Colors.blue, // button color
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
                                    _selectEndTime(context);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: Colors.blue,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(_nameController.text);
                            print(_dateController.text);
                            print(widget.psikiater);
                            showAlertDialog(context);
                            _createAppointment();
                          }
                        },
                        child: Text("Buat Jadwal", style: fontTheme.bodyText1),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    print(dateUTC + ' ' + 'Start at ' + date_Start_Time + ':00' + 'End at ' + date_End_Time + ':00');
    FirebaseFirestore.instance.collection('booking').doc(user.email).collection('pending').doc().set({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'psikiater': _psikiaterController.text,
      'date': DateTime.parse(dateUTC + ' ' + 'Start at ' + date_Start_Time + ':00' + ' End at ' + date_End_Time + ':00'),
    }, SetOptions(merge: true));

    FirebaseFirestore.instance.collection('booking').doc(user.email).collection('all').doc().set({
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'psikiater': _psikiaterController.text,
      'date': DateTime.parse(dateUTC + ' ' + 'Start at ' + date_Start_Time + ':00' + ' End at ' + date_End_Time + ':00'),
    }, SetOptions(merge: true));
  }
}
