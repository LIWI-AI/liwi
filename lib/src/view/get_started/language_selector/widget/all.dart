import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_ai/src/utils/styles/font_weight.dart';

import '../../../../utils/colors/main.dart';
import '../../../../utils/providers/language_list_provider.dart';
import '../../../../utils/widgets/texts.dart';

class AllLanguageOptions extends StatelessWidget {
  const AllLanguageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final languageListProvider = context.read<LanguageListProvider>();
    var pList = languageListProvider.allLanguages;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(context,
            text: 'All languages',
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: CustomFontWeight.semiBold,
                color: AppColors.textPrimary)),
        const SizedBox(height: 10),
        ListView.builder(
            itemCount: pList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: AppColors.overlay),
                      ),
                  child: Text(
                    pList[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: CustomFontWeight.medium,
                      color: AppColors.textPrimary,
                    ),
                  ));
            }),
      ],
    );
  }
}
