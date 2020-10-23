
import 'package:ramaz/src/data/contact_info.dart';

class Meeting{
  DateTime dateTime;
  String location;
  Duration duration;
  String studentMessage;
  String teacherMessage;
  ContactInfo student;
  ContactInfo teacher;
  String meetingReason;
  bool isInPerson;
  bool approvalStatus;
  Meeting(
      this.dateTime,
      this.duration,
      this.studentMessage,
      this.teacherMessage,
      this.student,
      this.teacher,
      this.meetingReason,
      this.isInPerson,
      this.approvalStatus,
      {this.location}
      );
}

