import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/features/Guru/message/services/repository_meeting.dart';

final meetingStateProvider = StateNotifierProvider((ref) {
  final meetingRepository = MeetingRepository();

  return MeetingStateNotifier(meetingRepository);
});

class MeetingStateNotifier extends StateNotifier<List<MeetingModel>> {
  final MeetingRepository _repository; // Your MeetingRepository instance

  MeetingStateNotifier(this._repository,
      [List<MeetingModel> initialMeetingModels = const []])
      : super(initialMeetingModels);

  Future<void> updateMeetingAccept({
    required String receiverId,
    required bool isAccept,
  }) async {
    try {
      await _repository.updateMeetingFieldById(
        receiverId: receiverId,
        isAccept: isAccept,
      );

      state = [...state.where((meeting) => meeting.id != receiverId)];
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> updateMeetingDecline({
    required String receiverId,
    required bool isDecline,
  }) async {
    try {
      await _repository.updateIsDeclineField(
        receiverId: receiverId,
        isDecline: isDecline,
      );

      state = [...state.where((meeting) => meeting.id != receiverId)];
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> updateMeetingPaymentStatus({
    required String senderId,
    required bool isDonePayment,
  }) async {
    try {
      await _repository.updateMeetingMakePaymentField(
        senderId: senderId,
        isDonePayment: isDonePayment,
      );

      state = [...state.where((meeting) => meeting.senderId != senderId)];
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
