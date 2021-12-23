part of 'widget.dart';

class HistoriCardWidget extends StatefulWidget {
  const HistoriCardWidget({Key? key}) : super(key: key);

  @override
  State<HistoriCardWidget> createState() => _HistoriCardWidgetState();
}

class _HistoriCardWidgetState extends State<HistoriCardWidget> {
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
                    'Belum ada histroy',
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
                                  height: 100,
                                  width: 100,
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Card(
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
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                                                  child: RichText(
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
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.blueAccent),
                                                  borderRadius: BorderRadius.circular(20),
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
