import 'event.dart';

class UpcomingEvents {
  final int noOfEvents;
  final String date;
  final List<Event> events;

  UpcomingEvents({
    required this.noOfEvents,
    required this.events,
    required this.date,
  });

  UpcomingEvents.fromJson(Map<String, dynamic> json)
      : noOfEvents = json['noOfEvents'],
        date = json['date'],
        events = (json['events'] as List<dynamic>?)!
            .map((eventMap) => Event.fromJson(eventMap as Map<String, dynamic>))
            .toList();
}
