part of 'util.dart';

class CalendarClient {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

// final calendar = new CalendarApi(client: );
  // late CalendarApi calendar;
  // var _credentials;
  static const _scopes = [CalendarApi.calendarScope];
  // static var calendar;

  Future<Map<String, String>?> insert({
    required String currentTitle,
    required String currentDesc,
    required String psikiaterName,
    required String pasienName,
    required String psikiaterSpesialist,
    required String psikiaterImage,
    required List<EventAttendee> attendeeEmailList,
    required bool shouldNotifyAttendees,
    required bool hasConferenceSupport,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    var _clientID = ClientId("389215821819-0i3ed9vl37gbh5qc3ro5hhn50q2k017e.apps.googleusercontent.com", "");

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var ambilUserOauth = prefs.getString('oauth_tersimpan');
    // print(ambilUserOauth);

    // if (ambilUserOauth != "confirmed") {
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      late Map<String, String> eventData;

      String calendarId = "primary";
      Event event = Event();

      event.summary = currentTitle;
      event.description = currentDesc;
      event.attendees = attendeeEmailList;

      EventDateTime start = EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+05:30";
      event.start = start;

      EventDateTime end = EventDateTime();
      end.timeZone = "GMT+05:30";
      end.dateTime = endTime;
      event.end = end;

      if (hasConferenceSupport) {
        ConferenceData conferenceData = ConferenceData();
        CreateConferenceRequest conferenceRequest = CreateConferenceRequest();
        conferenceRequest.requestId = "${startTime.millisecondsSinceEpoch}-${endTime.millisecondsSinceEpoch}";
        conferenceData.createRequest = conferenceRequest;

        event.conferenceData = conferenceData;
      }

      try {
        calendar.events.insert(event, calendarId, conferenceDataVersion: hasConferenceSupport ? 1 : 0, sendUpdates: shouldNotifyAttendees ? "all" : "none").then((value) async {
          print("Event Status: ${value.status}");

          if (value.status == "confirmed") {
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // var userOauth = "$value.status";
            // await prefs.setString('oauth_tersimpan', userOauth);

            late String joiningLink;
            late String eventId;

            eventId = value.id!;

            if (hasConferenceSupport) {
              joiningLink = "https://meet.google.com/${value.conferenceData!.conferenceId}";
            }

            eventData = {'id': eventId, 'link': joiningLink};
            List<String> emails = [];
            for (int i = 0; i < attendeeEmailList.length; i++) emails.add(attendeeEmailList[i].email!);
            _getUser();

            FirebaseFirestore.instance.collection('pasiens').doc(user!.uid).set({
              'userOauth': value.status,
            }, SetOptions(merge: true));

            FirebaseFirestore.instance.collection('booking').doc(user!.email).collection('pending').doc().set({
              'id': eventId,
              'link': joiningLink,
              'title': currentTitle,
              'description': currentDesc,
              'psikiaterEmail': emails,
              'psikiaterName': psikiaterName,
              'psikiaterSpesialist': psikiaterSpesialist,
              'psikiaterImage': psikiaterImage,
              'pasienName': pasienName,
              'startTime': startTime,
              'endTime': endTime,
            }, SetOptions(merge: true));

            FirebaseFirestore.instance.collection('booking').doc(user!.email).collection('all').doc().set({
              'id': eventId,
              'link': joiningLink,
              'title': currentTitle,
              'description': currentDesc,
              'psikiaterEmail': emails,
              'psikiaterName': psikiaterName,
              'psikiaterSpesialist': psikiaterSpesialist,
              'psikiaterImage': psikiaterImage,
              'pasienName': pasienName,
              'startTime': startTime,
              'endTime': endTime,
            }, SetOptions(merge: true));
            print('Event added to Google Calendar');
          } else {
            print("Unable to add event to Google Calendar");
          }
        });
      } catch (e) {
        print('Error creating event $e');
      }
      return eventData;
    });
    // }

    // return null;
  }

  // Future<Map<String, String>> modify({
  //   required String id,
  //   required String title,
  //   required String description,
  //   required String location,
  //   required List<EventAttendee> attendeeEmailList,
  //   required bool shouldNotifyAttendees,
  //   required bool hasConferenceSupport,
  //   required DateTime startTime,
  //   required DateTime endTime,
  // }) async {
  //   late Map<String, String> eventData;

  //   String calendarId = "primary";
  //   Event event = Event();

  //   event.summary = title;
  //   event.description = description;
  //   event.attendees = attendeeEmailList;
  //   event.location = location;

  //   EventDateTime start = new EventDateTime();
  //   start.dateTime = startTime;
  //   start.timeZone = "GMT+05:30";
  //   event.start = start;

  //   EventDateTime end = new EventDateTime();
  //   end.timeZone = "GMT+05:30";
  //   end.dateTime = endTime;
  //   event.end = end;

  //   try {
  //     await calendar.events.patch(event, calendarId, id, conferenceDataVersion: hasConferenceSupport ? 1 : 0, sendUpdates: shouldNotifyAttendees ? "all" : "none").then((value) {
  //       print("Event Status: ${value.status}");
  //       if (value.status == "confirmed") {
  //         late String joiningLink;
  //         late String eventId;

  //         eventId = value.id!;

  //         if (hasConferenceSupport) {
  //           joiningLink = "https://meet.google.com/${value.conferenceData!.conferenceId}";
  //         }

  //         eventData = {'id': eventId, 'link': joiningLink};

  //         print('Event updated in google calendar');
  //       } else {
  //         print("Unable to update event in google calendar");
  //       }
  //     });
  //   } catch (e) {
  //     print('Error updating event $e');
  //   }

  //   return eventData;
  // }

  // Future<void> delete(String eventId, bool shouldNotify) async {
  //   String calendarId = "primary";

  //   try {
  //     await calendar.events.delete(calendarId, eventId, sendUpdates: shouldNotify ? "all" : "none").then((value) {
  //       print('Event deleted from Google Calendar');
  //     });
  //   } catch (e) {
  //     print('Error deleting event: $e');
  //   }
  // }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
