import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';

final meetingRepository = Provider((ref) => MeetingRepository());

class MeetingRepository {
  Future addMeetingToFirebase({
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
    try {
      MeetingModel meetingModel = MeetingModel(
        senderName: senderName,
        senderPic: senderPic,
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
      await Amplify.DataStore.save(meetingModel).then((value) {
        return snackbar(
            context: context, content: 'Successfully saved your meeting');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<MeetingModel>> fetchAllMeetingsByStudentId({
    required String senderId,
  }) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.SENDERID.eq(senderId),
      );

      return meetings;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<void> updateMeetingFieldById({
    required String receiverId,
    required bool isAccept,
  }) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.RECEIVERID.eq(receiverId),
      );

      if (meetings.isNotEmpty) {
        final meetingToUpdate = meetings.first.copyWith(isAccept: isAccept);
        await Amplify.DataStore.save(meetingToUpdate);
      } else {
        debugPrint("No document found with receiverId: $receiverId");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> updateIsDeclineField({
    required String receiverId,
    required bool isDecline,
  }) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.RECEIVERID.eq(receiverId),
      );

      if (meetings.isNotEmpty) {
        final meetingToUpdate = meetings.first.copyWith(isDecline: isDecline);
        await Amplify.DataStore.save(meetingToUpdate);
        return true;
      } else {
        debugPrint("No document found with receiverId: $receiverId");
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());

      return false;
    }
  }

  Future<bool> updateMeetingMakePaymentField({
    required String senderId,
    required bool isDonePayment,
  }) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.SENDERID.eq(senderId),
      );

      if (meetings.isNotEmpty) {
        final meetingToUpdate =
            meetings.first.copyWith(isDonePayment: isDonePayment);
        await Amplify.DataStore.save(meetingToUpdate);
        return true;
      } else {
        debugPrint("No document found with senderId: $senderId");
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());

      return false;
    }
  }
}

final meetingStateNotifierProvider =
    StateNotifierProvider<MeetingStateNotifier, List<MeetingModel>>((ref) {
  return MeetingStateNotifier();
});

class MeetingStateNotifier extends StateNotifier<List<MeetingModel>> {
  MeetingStateNotifier() : super([]);

  Future<void> fetchMeetingsBySenderId(String senderId) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.SENDERID.eq(senderId),
      );

      state = meetings;
    } catch (e) {
      debugPrint('Error fetching meetings: $e');
    }
  }

  Future<void> updateMeetingAccept(String receiverId, bool isAccept) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.RECEIVERID.eq(receiverId),
      );

      if (meetings.isNotEmpty) {
        final meetingToUpdate = meetings.first.copyWith(isAccept: isAccept);
        await Amplify.DataStore.save(meetingToUpdate);
        state = [...state]; // Triggers state update
      } else {
        debugPrint("No meeting found with receiverId: $receiverId");
      }
    } catch (e) {
      debugPrint('Error updating meeting accept status: $e');
    }
  }

  Future<void> updateIsDecline(String receiverId, bool isDecline) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.RECEIVERID.eq(receiverId),
      );

      if (meetings.isNotEmpty) {
        final meetingToUpdate = meetings.first.copyWith(isDecline: isDecline);
        await Amplify.DataStore.save(meetingToUpdate);
        state = [...state]; // Triggers state update
      } else {
        debugPrint("No meeting found with receiverId: $receiverId");
      }
    } catch (e) {
      debugPrint('Error updating isDecline status: $e');
    }
  }

  Future<void> updatePaymentStatus(String senderId, bool isDonePayment) async {
    try {
      final meetings = await Amplify.DataStore.query(
        MeetingModel.classType,
        where: MeetingModel.SENDERID.eq(senderId),
      );

      if (meetings.isNotEmpty) {
        final meetingToUpdate =
            meetings.first.copyWith(isDonePayment: isDonePayment);
        await Amplify.DataStore.save(meetingToUpdate);
        state = [...state]; // Triggers state update
      } else {
        debugPrint("No meeting found with senderId: $senderId");
      }
    } catch (e) {
      debugPrint('Error updating payment status: $e');
    }
  }
}
