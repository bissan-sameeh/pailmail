import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pailmail/core/utils/show_date_converter.dart';
import 'package:pailmail/models/attachments/attachment.dart';
import 'package:pailmail/models/tags/tag.dart';
import 'package:pailmail/views/widgets/custom_photo_container.dart';
import 'package:pailmail/views/widgets/custom_status_container.dart';
import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomMailContainer extends StatefulWidget {
  const CustomMailContainer(
      {Key? key,
      required this.organizationName,
      required this.date,
      required this.subject,
      required this.description,
      required this.tags,
      required this.images,
      required this.color,
      this.endMargin = 0,
      required this.onTap})
      : super(key: key);
  final String organizationName;
  final String date;
  final String subject;
  final String description;
  final List<Tag> tags;
  final List<Attachment> images;
  final Color color;
  final double endMargin;
  final void Function() onTap;

  @override
  State<CustomMailContainer> createState() => _CustomMailContainerState();
}

class _CustomMailContainerState extends State<CustomMailContainer> with DateConverter {
  @override
  Widget build(BuildContext context) {
    //TODO : handel text color is blue if the message is not readed yet
    return Container(
      margin: EdgeInsetsDirectional.only(
        bottom: widget.endMargin,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomStatusContainer(
                            color: widget.color,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              widget.organizationName,
                              style:
                                  tileTextTitleStyle.copyWith(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          formatDate(  widget.date),
                          style: tileTextNumberStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: Text(
                    widget.subject,
                    style: tileTextTitleStyle.copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: Text(
                    widget.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                        const TextStyle(fontSize: 14, color: kGreyWhiteColor),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //TODO : add tags
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: widget.tags.length == 0
                      ? SizedBox()
                      : Wrap(children: [
                          for (int i = 0; i < widget.tags.length; i++) ...{
                            Text(
                              "#${widget.tags[i].name}",
                              style: tagsTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          }
                        ]),
                ),
                //TODO : get images from constuctor
                 SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.0),
                  child: Row(children: [
                    //TODO: Add Gesture detoctor
                    for (int i = 0; i < widget.images.length; i++) ...{
                      CustomPhotoContainer(
                        raduis: 48.r,
                        url: '$imageUrl/${widget.images[i].image}',
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                    }
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
