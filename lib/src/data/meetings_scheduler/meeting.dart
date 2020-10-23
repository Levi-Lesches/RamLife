
import 'package:ramaz/src/data/contact_info.dart';

class Meeting{
  var meetingDateTime;
  String location;
  String durration;
  String studentMessage;
  String teacherMessage;
  ContactInfo student;
  ContactInfo teacher;
  String meetingReason;
  bool inPerson;
  Meeting(this.meetingDateTime,this.durration,this.studentMessage, this.teacherMessage, this.student, this.teacher,
      this.meetingReason,this.inPerson,{this.location});
}

