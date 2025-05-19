import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.edit,
    required this.viewRoles,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function()? edit;
  final bool viewRoles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: kPrimaryBlueColor.withOpacity(0.1),
            ),
            child: Icon(icon, color: kPrimaryBlueColor),
          ),
          trailing: edit == null
              ? null
              : GestureDetector(
                  onTap: edit,
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kDarkGreyColor.withOpacity(0.1),
                    ),
                    child: viewRoles
                        ? Icon(
                            Icons.close,
                            color: kRedColor,
                          )
                        : Icon(Icons.edit, color: kDarkGreyColor),
                  ),
                ),
          title: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: kBlackColor)),
        ),
        Divider(),
      ],
    );
  }
}
