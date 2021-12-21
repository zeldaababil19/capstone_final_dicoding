part of 'ui.dart';

class SearchList extends StatefulWidget {
  final String searchKey;
  const SearchList({Key? key, required this.searchKey}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('psikiaters').orderBy('name').startAt([widget.searchKey]).endAt([widget.searchKey + '\uf8ff']).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return snapshot.data!.size == 0
                ? Center(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No psikiater found!',
                            style: GoogleFonts.lato(
                              color: Colors.blue[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/error-404.jpg'),
                            height: 250,
                            width: 250,
                          ),
                        ],
                      ),
                    ),
                  )
                : Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot psikiater = snapshot.data!.docs[index];
                        // return Padding(
                        //   padding: const EdgeInsets.only(top: 0.0),
                        //   child: Card(
                        //     color: Colors.blue[50],
                        //     elevation: 0,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: Container(
                        //       padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                        //       width: MediaQuery.of(context).size.width,
                        //       height: MediaQuery.of(context).size.height / 9,
                        //       child: TextButton(
                        //         onPressed: () {
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) => PsikiaterProfile(
                        //                 psikiater: psikiater['name'],
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //           children: [
                        //             CircleAvatar(
                        //               backgroundImage: NetworkImage(psikiater['image']),
                        //               //backgroundColor: Colors.blue,
                        //               radius: 25,
                        //             ),
                        //             SizedBox(
                        //               width: 20,
                        //             ),
                        //             Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Text(
                        //                   psikiater['name'],
                        //                   style: GoogleFonts.lato(
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 17,
                        //                     color: Colors.black87,
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   psikiater['type'],
                        //                   style: GoogleFonts.lato(fontSize: 16, color: Colors.black54),
                        //                 ),
                        //               ],
                        //             ),
                        //             SizedBox(
                        //               width: 10,
                        //             ),
                        //             Expanded(
                        //               child: Container(
                        //                 alignment: Alignment.centerRight,
                        //                 child: Row(
                        //                   crossAxisAlignment: CrossAxisAlignment.end,
                        //                   mainAxisAlignment: MainAxisAlignment.end,
                        //                   children: [
                        //                     // Icon(
                        //                     //   Typicons.star_full_outline,
                        //                     //   size: 20,
                        //                     //   color: Colors.indigo[400],
                        //                     // ),
                        //                     SizedBox(
                        //                       width: 3,
                        //                     ),
                        //                     Text(
                        //                       psikiater['rating'].toString(),
                        //                       style: GoogleFonts.lato(
                        //                         fontWeight: FontWeight.bold,
                        //                         fontSize: 15,
                        //                         color: Colors.indigo,
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),

                        // );

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
                                              imageUrl: psikiater['image'],
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 100,
                                              placeholder: (context, url) => const CircleAvatar(
                                                backgroundColor: Colors.blue,
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
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(psikiater['name'], style: fontTheme.bodyText1),
                                                        Text(psikiater['spesialis'], style: fontTheme.bodyText2),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 4),
                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children: <Widget>[
                                                                  const Icon(
                                                                    Icons.business_center,
                                                                    size: 16,
                                                                    color: greyColor,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Text(
                                                                    psikiater['experience'],
                                                                    style: fontTheme.bodyText2?.copyWith(
                                                                      color: darkGreyColor,
                                                                      fontSize: 11,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 6,
                                                              ),
                                                              Row(
                                                                children: <Widget>[
                                                                  Icon(
                                                                    Icons.star,
                                                                    size: 16,
                                                                    color: yellowColor,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Text(
                                                                    psikiater['rating'].toString(),
                                                                    style: fontTheme.bodyText2?.copyWith(
                                                                      color: darkGreyColor,
                                                                      fontSize: 11,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 6.0),
                                                      child: SizedBox(
                                                        height: 25,
                                                        child: ElevatedButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            'Buat Jadwal Meeting',
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PsikiaterProfile(
                                          psikiater: psikiater['name'],
                                        ),
                                      ),
                                    );
                                  },
                                );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
