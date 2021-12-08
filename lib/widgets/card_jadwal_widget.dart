part of 'widget.dart';

class JadwalCardWidget extends StatelessWidget {
  const JadwalCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  imageUrl: 'https://d1bpj0tv6vfxyp.cloudfront.net/articles/b153c05e-050d-4004-8669-8a86d3959255_article_image_url.webp',
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
                                      Text('Erni putri setyadji, M. Psi,', style: Theme.of(context).textTheme.bodyText1),
                                      Text('Psikologi Klinis', style: Theme.of(context).textTheme.bodyText2),
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
                                            Text(
                                              "10:00 - 11:00",
                                              style: mediumBaseFont.copyWith(
                                                color: greyColor,
                                                fontSize: 11,
                                              ),
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
                                          '25',
                                          style: mediumBaseFont.copyWith(
                                            color: whiteColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'Kam',
                                          style: mediumBaseFont.copyWith(
                                            color: whiteColor,
                                            fontSize: 12,
                                          ),
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
                                      style: mediumBaseFont.copyWith(
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
                                  onPressed: () {},
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
                                  onPressed: () {},
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
  }
}
