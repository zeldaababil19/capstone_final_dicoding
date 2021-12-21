part of 'ui.dart';

class PsikiaterProfile extends StatefulWidget {
  static const routeName = '/psikiater_detail_screen';

  final String psikiater;

  const PsikiaterProfile({Key? key, required this.psikiater}) : super(key: key);
  @override
  _PsikiaterProfileState createState() => _PsikiaterProfileState();
}

class _PsikiaterProfileState extends State<PsikiaterProfile> {
  _launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Psikiater'),
      ),
      backgroundColor: baseColor,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('psikiaters').orderBy('name').startAt([widget.psikiater]).endAt([widget.psikiater + '\uf8ff']).snapshots(),
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

                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: document['image'],
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                          placeholder: (context, url) => const CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 5,
                          ),
                          imageBuilder: (context, image) => CircleAvatar(
                            backgroundImage: image,
                            radius: 5,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Text(document['name'], textAlign: TextAlign.center, style: fontTheme.headline6),
                            const SizedBox(height: 10),
                            Text(document['email'], style: fontTheme.subtitle1),
                            Text(document['spesialis'], style: fontTheme.subtitle1),
                            Row(children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                              )),
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < document['rating']; i++)
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.indigoAccent,
                                    size: 30,
                                  ),
                                if (5 - document['rating'] > 0)
                                  for (var i = 0; i < 5 - document['rating']; i++)
                                    Icon(
                                      Icons.star_rounded,
                                      color: Colors.black12,
                                      size: 30,
                                    ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Pengalaman : ',
                                  style: fontTheme.bodyText1?.copyWith(
                                    color: darkGreyColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  document['experience'],
                                  style: fontTheme.bodyText1?.copyWith(
                                    color: darkGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                              )),
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.school),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Alumni', style: fontTheme.bodyText1),
                                      Text(document['graduated'].join("\n")),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.home_work),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('address', style: fontTheme.bodyText1),
                                      Text(document['address']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.collections_bookmark),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Nomor STR', style: fontTheme.bodyText1),
                                      Text(document['str']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.phone),
                                  // SizedBox(width: 12),
                                  TextButton(
                                    onPressed: () => _launchCaller("tel:" + document['phone']),
                                    child: Text(
                                      document['phone'],
                                      style: fontTheme.bodyText1?.copyWith(
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Jadwal', style: fontTheme.bodyText1),
                                      Text(
                                        document['openHour'] + " - " + document['closeHour'],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(
                            //   height: 50,
                            // ),
                            SizedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                  primary: whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingFakeScreen(),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => BookingScreen(
                                  //       psikiaterName: document['name'],
                                  //       psikiaterEmail: document['email'],
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  'Buat Jadwal Meet',
                                  style: fontTheme.bodyText1?.copyWith(
                                    color: accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
