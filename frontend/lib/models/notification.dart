// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Notification {
  final String title;
  final String newsType;
  final String link;
  final String dateTime;
  final String date;
  final String content;
  final String centre;
  final String moreInformation;

  const Notification({
    required this.title,
    required this.newsType,
    required this.link,
    required this.dateTime,
    required this.date,
    required this.content,
    required this.centre,
    required this.moreInformation,
  });

  Notification copyWith({
    String? title,
    String? newsType,
    String? link,
    String? dateTime,
    String? date,
    String? content,
    String? centre,
    String? moreInformation,
  }) {
    return Notification(
      title: title ?? this.title,
      newsType: newsType ?? this.newsType,
      link: link ?? this.link,
      dateTime: dateTime ?? this.dateTime,
      date: date ?? this.date,
      content: content ?? this.content,
      centre: centre ?? this.centre,
      moreInformation: moreInformation ?? this.moreInformation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'newsType': newsType,
      'link': link,
      'dateTime': dateTime,
      'date': date,
      'content': content,
      'centre': centre,
      'moreInformation': moreInformation,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      title: map['title'] as String,
      newsType: map['newsType'] as String,
      link: map['link'] as String,
      dateTime: map['dateTime'] as String,
      date: map['date'] as String,
      content: map['content'] as String,
      centre: map['centre'] as String,
      moreInformation: map['moreInformation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) => Notification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(title: $title, newsType: $newsType, link: $link, dateTime: $dateTime, date: $date, content: $content, centre: $centre, moreInformation: $moreInformation)';
  }

  @override
  bool operator ==(covariant Notification other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.newsType == newsType &&
      other.link == link &&
      other.dateTime == dateTime &&
      other.date == date &&
      other.content == content &&
      other.centre == centre &&
      other.moreInformation == moreInformation;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      newsType.hashCode ^
      link.hashCode ^
      dateTime.hashCode ^
      date.hashCode ^
      content.hashCode ^
      centre.hashCode ^
      moreInformation.hashCode;
  }
}
