part of 'widget.dart';

class PsikiaterCardWidget extends StatefulWidget {
  const PsikiaterCardWidget({Key? key}) : super(key: key);

  @override
  State<PsikiaterCardWidget> createState() => _PsikiaterCardWidgetState();
}

class _PsikiaterCardWidgetState extends State<PsikiaterCardWidget> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference psikiater = firestore.collection('psikiater');

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
              // StreamBuilder
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CachedNetworkImage(
                  imageUrl: 'https://d1bpj0tv6vfxyp.cloudfront.net/articles/b153c05e-050d-4004-8669-8a86d3959255_article_image_url.webp',
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
                            Text('Erni putri setyadji, M. Psi,', style: myTextTheme.bodyText1),
                            Text('Psikologi Klinis', style: myTextTheme.bodyText2),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.business_center,
                                        size: 16,
                                        color: greyColor,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "2 tahun",
                                        style: mediumBaseFont.copyWith(
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
                                        "4.5",
                                        style: mediumBaseFont.copyWith(
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
      // onTap: onTap,
    );
  }
}
