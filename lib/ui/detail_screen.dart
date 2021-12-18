import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_final/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

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
                          height: 200,
                          width: 200,
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
                                      Text('Alamat', style: fontTheme.bodyText1),
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

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   document['spesialis'],
                    //   style: GoogleFonts.lato(
                    //       //fontWeight: FontWeight.bold,
                    //       fontSize: 18,
                    //       color: Colors.black54),
                    // ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     for (var i = 0; i < document['rating']; i++)
                    //       Icon(
                    //         Icons.star_rounded,
                    //         color: Colors.indigoAccent,
                    //         size: 30,
                    //       ),
                    //     if (5 - document['rating'] > 0)
                    //       for (var i = 0; i < 5 - document['rating']; i++)
                    //         Icon(
                    //           Icons.star_rounded,
                    //           color: Colors.black12,
                    //           size: 30,
                    //         ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 14,
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 22, right: 22),
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     document['spesification'],
                    //     textAlign: TextAlign.center,
                    //     style: GoogleFonts.lato(
                    //       fontSize: 14,
                    //       color: Colors.black54,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       SizedBox(
                    //         width: 15,
                    //       ),
                    //       Icon(Icons.place_outlined),
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width / 1.4,
                    //         child: Text(
                    //           document['address'],
                    //           style: GoogleFonts.lato(
                    //             fontSize: 16,
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   height: MediaQuery.of(context).size.height / 12,
                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 15,
                    //       ),
                    //       Icon(Icons.phone),
                    //       SizedBox(
                    //         width: 11,
                    //       ),
                    //       TextButton(
                    //         onPressed: () => _launchCaller("tel:" + document['phone']),
                    //         child: Text(
                    //           document['phone'].toString(),
                    //           style: GoogleFonts.lato(fontSize: 16, color: Colors.blue),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 0,
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 15,
                    //       ),
                    //       Icon(Icons.access_time_rounded),
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //       Text(
                    //         'Working Hours',
                    //         style: GoogleFonts.lato(
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                    //   padding: EdgeInsets.only(left: 60),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Today: ',
                    //         style: GoogleFonts.lato(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text(
                    //         document['openHour'] + " - " + document['closeHour'],
                    //         style: GoogleFonts.lato(
                    //           fontSize: 17,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 30),
                    //   height: 50,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       elevation: 2,
                    //       primary: Colors.indigo.withOpacity(0.9),
                    //       onPrimary: Colors.black,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(32.0),
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       // Navigator.push(
                    //       //   context,
                    //       //   MaterialPageRoute(
                    //       //     builder: (context) => BookingScreen(
                    //       //       psikiater: document['name'],
                    //       //     ),
                    //       //   ),
                    //       // );
                    //     },
                    //     child: Text(
                    //       'Book an Appointment',
                    //       style: GoogleFonts.lato(
                    //         color: Colors.white,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
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
