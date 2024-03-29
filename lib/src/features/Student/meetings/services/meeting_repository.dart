import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';

class MeetingRepository {
  Future<bool> addMeeting({
    required String senderId,
    required String recieverId,
    required String senderName,
    required String senderPic,
    required String recieverName,
    required String recieverPic,
    required String date,
    required String time,
    required bool isAudio,
    required bool isAccept,
    required bool isVideo,
    required bool isDone,
    required bool isDecline,
    required bool isDonePayment,
    required BuildContext context,
  }) async {
    MeetingModel meetingModel = MeetingModel(
      senderName: senderName,
      // sender: senderPic,
      senderId: senderId,
      receiverId: recieverId,
      receiverName: recieverName,
      receiverPic: recieverPic,
      date: date,
      time: time,
      isAudio: isAudio,
      isAccept: isAccept,
      isVideo: isVideo,
      isDone: isDone,
      isDecline: isDecline,
      isDonePayment: isDonePayment,
    );
    try {
      await Amplify.DataStore.save(meetingModel);
      return true;
    } on DataStoreException catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.message);
      }
      return false;
    }
  }

  Future<List<MeetingModel>> fetchAllMeetingsById({
    required String senderID,
    required BuildContext context,
  }) async {
    try {
      // Query all MeetingModel objects from the DataStore
      List<MeetingModel> meetings = await Amplify.DataStore.query(
          MeetingModel.classType,
          where: MeetingModel.SENDERID.eq(senderID));
      return meetings;
    } on DataStoreException catch (e) {
      if (context.mounted) {
        snackbar(context: context, content: e.message);
      }
      // Handle exceptions or errors here
      debugPrint("Error fetching meetings: $e");
      return []; // Return an empty list or handle error accordingly
    }
  }

  Future<MeetingModel?> getMeetingById(String meetingId) async {
    try {
      final meeting = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.ID.eq(meetingId),
      );

      if (meeting.isNotEmpty) {
        return meeting.first;
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching meeting: $e");
      return null;
    }
  }

  Future<void> updateMeetingAcceptance(String meetingId) async {
    try {
      final meeting = await getMeetingById(meetingId);

      if (meeting != null) {
        final updatedMeeting = meeting.copyWith(isAccept: true);
        await Amplify.DataStore.save(updatedMeeting);
      }
    } catch (e) {
      debugPrint("Error updating meeting acceptance: $e");
    }
  }

  Future<void> updateMeetingDecline(String meetingId) async {
    try {
      final meeting = await getMeetingById(meetingId);

      if (meeting != null) {
        final updatedMeeting = meeting.copyWith(isDecline: true);
        await Amplify.DataStore.save(updatedMeeting);
      }
    } catch (e) {
      debugPrint("Error updating meeting decline: $e");
    }
  }

  Future<void> updateMeetingPayment(String meetingId) async {
    try {
      final meeting = await getMeetingById(meetingId);

      if (meeting != null) {
        final updatedMeeting = meeting.copyWith(isDonePayment: true);
        await Amplify.DataStore.save(updatedMeeting);
      }
    } catch (e) {
      debugPrint("Error updating meeting payment: $e");
    }
  }

  Future<void> updateMeetingField({
    required String senderId,
    required bool isAccept,
    required isDecline,
    required bool isDonePayment,
  }) async {
    try {
      final meeting = await getMeetingById(senderId);

      if (meeting != null) {
        final updatedMeeting = meeting.copyWith(
          isDonePayment: isDonePayment,
          isAccept: isAccept,
          isDecline: isDecline,
        );
        await Amplify.DataStore.save(updatedMeeting);
      }
    } catch (e) {
      debugPrint("Error updating meeting payment: $e");
    }
  }
}
