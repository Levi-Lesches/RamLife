
import 'package:ramaz/src/data/contact_info.dart';

class Meeting{
  DateTime dateTime;
  String location;
  String duration;
  String studentMessage;
  String teacherMessage;
  ContactInfo student;
  ContactInfo teacher;
  String meetingReason;
  bool isInPerson;
  bool isApproved;
  Meeting(
      this.dateTime,
      this.duration,
      this.studentMessage,
      this.teacherMessage,
      this.student,
      this.teacher,
      this.meetingReason,
      this.isInPerson,
      this.isApproved,
      {this.location}
      );
}

