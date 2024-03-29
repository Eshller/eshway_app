
import 'package:flutter_riverpod/flutter_riverpod.dart';

final guruRepoProvider = Provider<GuruController>((ref) {

  return GuruController(

    ref: ref,
  );
});
final guruDataProvider =
    FutureProvider.autoDispose((ref) async {
  final authController = ref.watch(guruRepoProvider);

  return authController.fetAllGuru();
});

final getGuruDataProvider = FutureProvider.autoDispose((ref) {
  final authController = ref.watch(guruRepoProvider);
  return authController.getCurrentGuru();
});
final guruStreamProvider = StreamProvider((ref) {
  final authController = ref.watch(guruRepoProvider);
  return authController.getCurrentGuruData();
});

class GuruController {

  final ProviderRef ref;
  GuruController({

    required this.ref,
  });
  Future  fetAllGuru() async {

  }

  Stream getCurrentGuruData()async*{

  }

  Future fetchAllReview({
    required String recieverId,
    required String senderId,
  }) async {



  }

  Future getCurrentGuru()async {

  }
}
