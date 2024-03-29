// ignore_for_file: depend_on_referenced_packages

import 'package:caffae_app/src/Global/Export/export.dart';

import 'package:shimmer/shimmer.dart';

class GuruBrowserPage extends StatefulWidget {
  const GuruBrowserPage({super.key});

  @override
  State<GuruBrowserPage> createState() => _GuruBrowserPageState();
}

class _GuruBrowserPageState extends State<GuruBrowserPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          SearchHeader(
            searchController: searchController,
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(
            height: 22,
          ),
          ReusableText(
            text: 'Message your peer gurus for free!',
            textStyle: appStyle(
              fontSize: 14,
              fw: FontWeight.w400,
              color: customBlueColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            thickness: 1,
            color: blackColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Row(
                  children: [
                    ReusableText(
                      text: 'Sort',
                      textStyle: appStyle(
                        fw: FontWeight.w600,
                        fontSize: 18,
                        color: blackColor,
                      ),
                    ),
                    const Icon(Icons.sort)
                  ],
                ),
                const SizedBox(
                  width: 13,
                ),
                Row(
                  children: [
                    ReusableText(
                      text: 'Filter',
                      textStyle: appStyle(
                        fw: FontWeight.w600,
                        fontSize: 18,
                        color: blackColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 64, right: 8, left: 8),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: Future.value(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: shimmerBaseColor,
                            highlightColor: shimmerHighlightColor,
                            child: ListView.builder(
                                itemCount: 9,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GlobalContainer(
                                      height: 115,
                                      borderWidth: 1.1,
                                      width: MediaQuery.of(context).size.width,
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(18),
                                      child: const Text(''),
                                    ),
                                  );
                                }),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        } else if (snapshot.hasData) {
                          final data = snapshot.data;
                          return const Text('data');
                          /* return ListView.builder(
                              itemCount: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                final userData = data[index];
                                final name = userData.username;

                                if (searchController.text.isEmpty) {
                                  return SearchCard(userData: userData);
                                } else if (name!.toLowerCase().contains(
                                    searchController.text
                                        .toLowerCase()
                                        .toString())) {
                                  return SearchCard(userData: userData);
                                }
                                return Container();
                              });*/
                        } else {
                          return const Center(
                            child: Text(
                              'No data found ',
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
