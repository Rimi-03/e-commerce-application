import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_textstyles.dart';

class QuestionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const QuestionCard({
    super.key,
    required this.title,
    required this.icon,
   });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark?
            Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: AppTextStyle.withColor(
            AppTextStyle.bodyMedium,
            Theme.of(context).textTheme.bodyLarge!.color!,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isDark ? Colors.grey [400] : Colors.grey [600],
          size: 16,
        ),
        onTap: ()=> _showAnswerBottomSheet(context, title, isDark),
      ),
    );
  }

  void _showAnswerBottomSheet(BuildContext context, String question, bool isDark){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(question,
                      style: AppTextStyle.withColor(
                        AppTextStyle.bodyMedium,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                ),
                IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'questions',
              style: AppTextStyle.withColor(
                AppTextStyle.bodyMedium,
                isDark ? Colors.grey [400]! : Colors.grey [600]!,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
