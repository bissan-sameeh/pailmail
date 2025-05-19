import 'package:pailmail/models/tags/tag.dart';
import 'package:pailmail/providers/tag_provider.dart';
import 'package:pailmail/views/features/inbox_mails/inbox_screen.dart';
import 'package:pailmail/views/widgets/custom_app_bar.dart';
import 'package:pailmail/views/widgets/custom_chip.dart';
import 'package:pailmail/views/widgets/custom_mail_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/api_helpers/api_response.dart';
import '../../../core/utils/constants.dart';
import '../../../repositories/tag_repository.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen(
      {Key? key, this.tags, this.navFromHome = false, this.selectedTag, this.mailDetails=false})
      : super(key: key);
  final List<Tag>? tags;
  final bool navFromHome;
  final bool? mailDetails;
  final int? selectedTag;
  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  late TextEditingController _tagTextEditingController;
  // List<Tags> tags = [Tags("all_tags".tr(), false)];

  // Map<String,dynamic> tags = {name:"all_tags".tr(),isPressed:false};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tagTextEditingController = TextEditingController();
   if( widget.navFromHome) { selectedTagsId.add(widget.selectedTag!) ;}
   else{
     if(widget.tags!=null  && widget.tags!.isNotEmpty ){
       selectedTagsId=widget.tags!.map((tag) => tag.id ??0,).toList();
     }
   }

    allTagPress = selectedTagsId.contains(-1);
    print("----------------------${selectedTagsId}");
    // Provider.of<TagProvider>(context).tagList;
  }

  List<int> selectedTagsId = [];
  late bool allTagPress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
            child: Padding(
      padding:
          EdgeInsetsDirectional.only(start: 20.0.w, end: 20.0.w, bottom: 12.h),

      child: SizedBox(
        height: MediaQuery.of(context).size.height-45.h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: widget.navFromHome ? 0 : 26.0),
                child: CustomAppBar(
                  widgetName: 'Tags',
                  onTap: () {
                    print("**************${selectedTagsId.length}");
                    Navigator.pop(context, selectedTagsId);
                  },
                  isEdit: true,
                ),
              ),
              widget.navFromHome
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      child: Wrap(
                        //TODO:Handle move to tag screen
                        spacing: 6,
                        children: [
                          CustomChip(
                            text: "allTags".tr(),
                            onPressed: () {
                              //  allTagPress = !allTagPress;
                              //      setState(() {});
                              if (!selectedTagsId.contains(-1)) {
                                selectedTagsId.clear();
                                selectedTagsId.add(-1);
                                Provider.of<TagProvider>(context, listen: false)
                                    .getTagWithMailList("all");
                              } else {}

                              setState(() {});
                            },
                            isPressed: selectedTagsId.contains(-1),
                          ),
                          for (int i = 0; i < widget.tags!.length; i++) ...{
                            CustomChip(
                                text: "${widget.tags![i].name}",
                                isPressed:
                                    selectedTagsId.contains(widget.tags![i].id),
                                onPressed: () {
                                  if (selectedTagsId.contains(widget.tags![i].id)) {
                                    selectedTagsId.remove(widget.tags![i].id);
                                    Provider.of<TagProvider>(context, listen: false)
                                        .getTagWithMailList("$selectedTagsId");
                                  } else {
                                    selectedTagsId.remove(-1);
                                    selectedTagsId.add(widget.tags![i].id!);
                                    Provider.of<TagProvider>(context, listen: false)
                                        .getTagWithMailList("$selectedTagsId");
                                    print(
                                        "----------------------${selectedTagsId.length}");
                                    print(
                                        "----------------------${selectedTagsId[0]}");
                                  }
                                  setState(() {});
                                }),
                          }
                        ],
                      ),
                    )
                  : widget.mailDetails==true ? widget.tags != null && widget.tags!.isNotEmpty
                  ? Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Wrap(
                  spacing: 6,
                  children: [
                    CustomChip(
                      text: "allTags".tr(),
                      onPressed: () {
                        if (!selectedTagsId.contains(-1)) {
                          selectedTagsId.clear();
                          selectedTagsId.add(-1);
                          Provider.of<TagProvider>(context, listen: false).getTagWithMailList("all");
                        }
                        setState(() {});
                      },
                      isPressed: selectedTagsId.contains(-1),
                    ),
                    for (int i = 0; i < widget.tags!.length; i++)
                      CustomChip(
                        text: "${widget.tags![i].name}",
                        isPressed: selectedTagsId.contains(widget.tags![i].id),
                        onPressed: () {
                          if (selectedTagsId.contains(widget.tags![i].id)) {
                            selectedTagsId.remove(widget.tags![i].id);
                          } else {
                            selectedTagsId.remove(-1);
                            selectedTagsId.add(widget.tags![i].id!);
                          }
                          Provider.of<TagProvider>(context, listen: false).getTagWithMailList("$selectedTagsId");
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ) :const Text('Sorry no tags yet !'):Consumer<TagProvider>(
                      builder: (context, value, child) {
                        if (value.tagList.status == ApiStatus.LOADING ||
                            value.tagList.status == ApiStatus.ERROR) {
                          return spinkit;
                        } else {
                          if (value.tagList.data!.isEmpty) {
                            return const SizedBox.shrink();
                          } else {
                            var tags = value.tagList.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsetsDirectional.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      30,
                                    ),
                                  ),
                                  child: Wrap(
                                    //TODO:Hnadle move to tag screen
                                    spacing: 6,
                                    children: [
                                      // CustomChip(
                                      //   isHomeTag: true,
                                      //   text: "allTags".tr(),
                                      //   onPressed: () {
                                      //     Provider.of<TagProvider>(context,
                                      //             listen: false)
                                      //         .getTagWithMailList("all");
                                      //     // var tag =
                                      //     //     Provider.of<TagProvider>(
                                      //     //             context,
                                      //     //             listen: true)
                                      //     //         .tagWithMailList;
                                      //     // print("${tag.status}");
                                      //     Navigator.push(context, MaterialPageRoute(
                                      //       builder: (context) {
                                      //         return TagsScreen(
                                      //           selectedTag: -1,
                                      //           tags: tags,
                                      //           navFromHome: true,
                                      //         );
                                      //       },
                                      //     ));
                                      //   },
                                      // ),
                                      for (int i = 0; i < tags.length; i++) ...{
                                        CustomChip(
                                            isPressed: selectedTagsId
                                                .contains(tags![i].id),
                                            text: "${tags[i].name}",
                                            isHomeTag: true,
                                            onPressed: () {
                                              if (selectedTagsId
                                                  .contains(tags![i].id)) {
                                                selectedTagsId.remove(tags![i].id);
                                              } else {
                                                selectedTagsId.add(tags![i].id!);
                                              }
                                              print(
                                                  "///////////${selectedTagsId.length}");
                                            }),
                                      }
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      },
                    ),
              const SizedBox(
                height: 12,
              ),
              //TODO : This contant diff btn add tag from show email under this tag!!
              //TODO: Handle these 2 choice
              !widget.navFromHome
                  ? TextField(
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) {
                        //TODO:ADD Tag
                        TagRepository()
                            .createTag(_tagTextEditingController.text)
                            .then((value) {
                          // print("**********${}");
                          // if(value){
                          selectedTagsId.add(value); //TODO CLICK IT
                          print("Hlllllllllllllllllllll");
                          Provider.of<TagProvider>(context, listen: false)
                              .getTagList();
                          // }

                          //setState(() {});
                        });
                        // Provider.of<TagProvider>(context, listen: false)
                        //     .getTagList();
                        // widget.tags.add(
                        //     Tags(_tagTextEditingController.text, true));

                        _tagTextEditingController.clear();
                        setState(() {});
                      },
                      controller: _tagTextEditingController,
                      keyboardType: TextInputType.text,
                      //TODO :Create new color
                      style: const TextStyle(color: Color(0xff707070)),
                      cursorColor: const Color(0xff707070),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        hintText: "Add New Tag…",
                        hintStyle: buildAppBarTextStyle(
                            fontSizeController: 14,
                            color: const Color(0xFFC4C4C4),
                            //TODO : Check below color !!!!!!
                            // color: const Color(0xffafafaf),
                            letterSpacing: 0.15),
                      ),
                    )
                  : Expanded(
                      child: Consumer<TagProvider>(
                        builder: (context, value, child) {
                          if (value.tagWithMailList.status == ApiStatus.LOADING) {
                            return Skeletonizer(
                              enabled: true,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius: BorderRadius.circular(15.r)),
                                    child: ListTile(
                                      title: Text('Item number  as title'),
                                      subtitle: Text('Subtitle here'),
                                      trailing: Icon(
                                        Icons.ac_unit,
                                        size: 32,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (value.tagWithMailList.status ==
                              ApiStatus.ERROR) {
                            print(
                                "--------${value.tagWithMailList.message}------------");
                            return Text("Smth wrongm");
                          } else {
                            var mails = value.tagWithMailList.data!;
                            // var mails = value.tagWithMailList.data!;
                            if (mails!.isEmpty) {
                              print("eeeeeeeeeeeeeeee");
                              return const Text(
                                "No mails",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              //  print("----------${mails!.length}");
                              return ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = mails[index].mails;
                                  print("----------${data!.length}");
                                  if (data!.isNotEmpty) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        child:
                                        return CustomMailContainer(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return InboxScreen(
                                                  isDetails: true,
                                                  mail: data[index],
                                                );
                                              },
                                            ));
                                          },
                                          organizationName:
                                              data![i].sender!.name ?? "",
                                          color: Color(int.parse(
                                              data[i].status!.color.toString())),
                                          date: data[i].archiveDate ?? "",
                                          description: data[i].description ?? "",
                                          images: data[i].attachments ?? [],
                                          tags: data[i].tags ?? [],
                                          subject: data[i].subject ?? "",
                                          endMargin: 8,
                                        );
                                      },
                                      itemCount: data.length,
                                    );

                                  } else {
                                    return const Center(
                                      child: Text(
                                        "No mails",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                itemCount: mails.length,
                              );
                            }
                          }
                        },
                      ),
                    ),
              //TODO: modify the visibility of textfield
            ],
          ),
        ),
      ),
    )));
  }
}

class Tags {
  late String name;
  late bool isPressed;

  Tags(this.name, this.isPressed);
}
