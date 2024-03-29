// ignore_for_file: depend_on_referenced_packages

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:caffae_app/models/ModelProvider.dart';
import 'package:caffae_app/src/Global/Export/export.dart';
import 'package:caffae_app/src/Global/Utils/personalization_model.dart';
import 'package:caffae_app/src/Global/widgets/cached_network_image.dart';
import 'package:caffae_app/src/Global/widgets/rating.dart';
import 'package:caffae_app/src/features/Guru/Screens/guru_profile.dart';
import 'package:caffae_app/src/features/Student/widgets/rich_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuruCard extends StatelessWidget {
  final GuruModel userData;
  const GuruCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.all(3),
      elevation: 30,
      child: GlobalContainer(
        height: 115,
        borderWidth: 1.1,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 87,
                    width: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkIm(
                      imageUrl: userData.imageUrl.toString(),
                      height: 87,
                      width: 87,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichTextWidget(
                                  title1: 'Name: ',
                                  title2: userData.username!.length > 9
                                      ? "${userData.username.toString().substring(0, 9)}..."
                                      : userData.username.toString(),
                                ),
                              ),
                              const RatingButton(
                                rating: 4,
                                ignoreGestures: false,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          RichTextWidget(
                            title1: 'Experience: ',
                            title2:
                                '${userData.yearOfExperience.toString()}+ exp',
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 30,
                            child: RichTextWidget(
                              title1: "About: ",
                              title2: userData.about.toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         GuruProfileScreen(guruModel: userData),
                              //   ),
                              // );
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 22,
                                width: 90,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      HexColor('#2166FD'),
                                      HexColor('#0FC0FA'),
                                    ],
                                  ),
                                ),
                                child: ReusableText(
                                  text: 'View profile',
                                  textStyle: appStyle(
                                    fw: FontWeight.bold,
                                    fontSize: 11.3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SortOption {
  rating,
  experience,
  voiceCharge,
  videoCharge,
}

SortOption selectedSortOption = SortOption.rating;

class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}

class GuruSearchPage extends ConsumerStatefulWidget {
  static const String routeName = 'search-page';
  const GuruSearchPage({super.key});

  @override
  ConsumerState<GuruSearchPage> createState() => _GuruSearchPageState();
}

class _GuruSearchPageState extends ConsumerState<GuruSearchPage> {
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int? selectedIndex;
  bool gridViewVisible = true;

  int selectedPerIndex = -1;
  List<GuruModel>? gurus = [];
  Future<List<GuruModel>> fetchGurusByUserListExplore(
      String exploreValue) async {
    try {
      // Then, fetch Gurus based on the extracted Guru ids
      final List<GuruModel> gurus = await Amplify.DataStore.query(
        GuruModel.classType,
        where: GuruModel.SPECIALIST.contains(exploreValue),
      );

      return gurus;
    } catch (e) {
      debugPrint('Error fetching gurus by user list explore: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          // Center(
          //     child: Image.asset(
          //   'assets/images/logo.png',
          //   filterQuality: FilterQuality.low,
          //   opacity: const AlwaysStoppedAnimation(.37),
          //   height: 320,
          //   width: 320,
          //   fit: BoxFit.cover,
          // )),
          const SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 26,
                  color: HexColor("#283246"),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 9),
                        suffixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 44),
                  height: 30,
                  decoration: BoxDecoration(
                      color: kBackGroundColors,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/svg/game-icons_two-coins.svg'),
                      ReusableText(
                        text: '10',
                        textStyle: appStyle(
                          fw: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (selectedIndex == null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: per.length,
                  itemBuilder: (context, index) {
                    final d = per[index];
                    return GestureDetector(
                      onTap: () {
                        fetchGurusByUserListExplore(per[index].name)
                            .then((fetchedGurus) {
                          setState(() {
                            gurus = fetchedGurus;
                          });
                        }).catchError((error) {
                          // Handle any errors that occur during the fetch
                        });
                        setState(() {
                          selectedIndex = index;
                          gridViewVisible = false;
                        });
                      },
                      child: GlobalContainer(
                        borderWidth: 1.1,
                        height: 47,
                        width: MediaQuery.of(context).size.width / 3,
                        color: kBackGroundColors,
                        borderRadius: BorderRadius.circular(18),
                        child: ReusableText(
                          text: d.name,
                          textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (selectedIndex != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 34,
                  child: Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: kBackGroundColors,
                    label: ReusableText(
                      text: per[selectedIndex!].name,
                      textStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    deleteIconColor: Colors.white,
                    onDeleted: () {
                      setState(() {
                        selectedIndex = null;
                        gridViewVisible = true;
                      });
                    },
                  ),
                ),
              ),
            ),
          if (!gridViewVisible)
            const SizedBox(
              height: 22,
              child: Divider(
                thickness: 1.2,
                color: Colors.black,
              ),
            ),
          if (!gridViewVisible)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                children: [
                  Row(
                    children: [
                      ReusableText(
                        text: 'Sort',
                        textStyle: appStyle(
                          fw: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                ],
              ),
            ),
          if (!gridViewVisible)
            const SizedBox(
              height: 10,
            ),
          if (!gridViewVisible)
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6, left: 6, bottom: 62),
                  child: Column(
                    children: [
                      gurus!.isEmpty
                          ? Center(
                              child: Text(
                                '${per[selectedIndex!].name} data not found',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19),
                              ),
                            )
                          : ListView.builder(
                              itemCount: gurus!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                final userData = gurus![index];
                                final name = userData.username;

                                if (searchController.text.isEmpty) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    margin: const EdgeInsets.all(3),
                                    elevation: 30,
                                    child: GlobalContainer(
                                      height: 115,
                                      borderWidth: 1.1,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 85,
                                                  width: 84,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      onError: (s, t) {
                                                        const Text(
                                                          'Error to load the image',
                                                        );
                                                      },
                                                      fit: BoxFit.fitWidth,
                                                      image: NetworkImage(
                                                        userData.imageUrl
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 2,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: RichTextWidget(
                                                                  title1:
                                                                      'Name: ',
                                                                  title2: userData
                                                                              .username!
                                                                              .length >
                                                                          9
                                                                      ? "${userData.username.toString().substring(0, 9)}..."
                                                                      : userData
                                                                          .username
                                                                          .toString()),
                                                            ),
                                                            const RatingButton(
                                                              rating: 4,
                                                              ignoreGestures:
                                                                  true,
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        RichTextWidget(
                                                          title1:
                                                              'experience: ',
                                                          title2:
                                                              '${userData.yearOfExperience.toString()}+ exp',
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        RichTextWidget(
                                                          title1: "About: ",
                                                          title2: userData.about
                                                              .toString(),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        GuruProfileScreen(
                                                                  guruModel:
                                                                      userData,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Container(
                                                              height: 22,
                                                              width: 90,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    HexColor(
                                                                        '#2166FD'),
                                                                    HexColor(
                                                                        '#0FC0FA'),
                                                                  ],
                                                                ),
                                                              ),
                                                              child:
                                                                  ReusableText(
                                                                text:
                                                                    'View profile',
                                                                textStyle:
                                                                    appStyle(
                                                                  fw: FontWeight
                                                                      .bold,
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (name!.toLowerCase().contains(
                                    searchController.text
                                        .toLowerCase()
                                        .toString())) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    elevation: 30,
                                    child: GlobalContainer(
                                      height: 115,
                                      borderWidth: 1.1,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 85,
                                                  width: 84,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fitWidth,
                                                      onError: (s, t) {
                                                        const Text(
                                                          'Error to load the image',
                                                        );
                                                      },
                                                      image: NetworkImage(
                                                        userData.imageUrl
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 2,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: RichTextWidget(
                                                                  title1:
                                                                      'Name: ',
                                                                  title2: userData
                                                                              .username!
                                                                              .length >
                                                                          9
                                                                      ? "${userData.username.toString().substring(0, 9)}..."
                                                                      : userData
                                                                          .username
                                                                          .toString()),
                                                            ),
                                                            const RatingButton(
                                                              rating: 4,
                                                              ignoreGestures:
                                                                  true,
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        RichTextWidget(
                                                          title1:
                                                              'experience: ',
                                                          title2:
                                                              '${userData.experience.toString()}+ exp',
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        RichTextWidget(
                                                          title1: "About: ",
                                                          title2: userData.about
                                                              .toString(),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        InkWell(
                                                          onTap: () {},
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Container(
                                                              height: 22,
                                                              width: 90,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    HexColor(
                                                                        '#2166FD'),
                                                                    HexColor(
                                                                        '#0FC0FA'),
                                                                  ],
                                                                ),
                                                              ),
                                                              child:
                                                                  ReusableText(
                                                                text:
                                                                    'View profile',
                                                                textStyle:
                                                                    appStyle(
                                                                  fw: FontWeight
                                                                      .bold,
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
