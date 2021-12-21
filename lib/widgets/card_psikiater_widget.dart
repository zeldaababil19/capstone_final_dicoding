part of 'widget.dart';

class PsikiaterCardWidget extends StatefulWidget {
  const PsikiaterCardWidget({Key? key}) : super(key: key);

  @override
  State<PsikiaterCardWidget> createState() => _PsikiaterCardWidgetState();
}

class _PsikiaterCardWidgetState extends State<PsikiaterCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('psikiaters').orderBy('rating', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                DocumentSnapshot psikiater = snapshot.data!.docs[index];
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
              
              });
        },
      ),
    );
  }
}
