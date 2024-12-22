// import 'package:animated_switcher_plus/animated_switcher_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bounce/flutter_bounce.dart';
// import 'package:super_tooltip/super_tooltip.dart';
// import 'package:loading_indicator/loading_indicator.dart';
//
// import '../../../../core/constants/app_color.dart';
// import '../../../../core/constants/app_font_size.dart';
// import '../../../../core/constants/app_spacing.dart';
// import '../../../../core/extensions/context_extension.dart';
// import '../../../../core/extensions/num_extension.dart';
// import '../../../../generated/l10n.dart';
// import '../../../shared/presentations/widgets/icon_with_text.dart';
// import '../../data/models/overall_analysis_result.dart';
// import '../blocs/validate_habit/validate_habit_bloc.dart';
// import 'smart_tooltip.dart';
//
// class SmartCriteriaContainer extends StatelessWidget {
//   const SmartCriteriaContainer({super.key});
//
//   static const _smartTextStyle = TextStyle(
//     fontSize: AppFontSize.bodyLarge,
//     fontWeight: FontWeight.bold,
//   );
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ValidateHabitBloc, ValidateHabitState>(
//       builder: (context, state) {
//         if (state is ValidateHabitInitial) {
//           return const SizedBox.shrink();
//         }
//
//         return AnimatedSwitcherPlus.translationLeft(
//             duration: const Duration(milliseconds: 500),
//             child: Column(
//               children: [
//                 Container(
//                   color: Colors.grey.withOpacity(0.2),
//                   width: MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.all(AppSpacing.marginS),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SuperTooltip(
//                         showBarrier: true,
//                         showDropBoxFilter: true,
//                         sigmaX: 10,
//                         sigmaY: 10,
//                         content: const SmartTooltip(),
//                         child: const IconWithText(
//                           icon: Icons.info_outline_rounded,
//                           iconColor: AppColors.primary,
//                           text: 'SMART',
//                           fontSize: AppFontSize.h3,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: AppSpacing.marginS),
//                       buildSmartMetrics(overallResult, _smartTextStyle),
//                       const SizedBox(height: AppSpacing.marginS),
//                       if (overallResult != OverallAnalysisResult.init())
//                         RichText(
//                           text: TextSpan(children: [
//                             TextSpan(
//                               text: '${S.current.summary_title}: ',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: context.isDarkMode
//                                     ? AppColors.lightText
//                                     : AppColors.darkText,
//                                 fontSize: AppFontSize.h4,
//                               ),
//                             ),
//                             TextSpan(
//                               text: overallResult.summary,
//                               style: TextStyle(
//                                 color: context.isDarkMode
//                                     ? AppColors.lightText
//                                     : AppColors.darkText,
//                                 fontSize: AppFontSize.h4,
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),
//                           ]),
//                         ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: AppSpacing.marginS),
//                 (overallResult == OverallAnalysisResult.init() ||
//                         overallResult.improvedSentence.isEmpty)
//                     ? const SizedBox.shrink()
//                     : (overallResult.overallScore >= 80)
//                         ? IconWithText(
//                             width: MediaQuery.of(context).size.width,
//                             icon: Icons.check,
//                             text: S.current.smart_criteria_achieved,
//                             iconColor: AppColors.success,
//                             backgroundColor: AppColors.success.withOpacity(0.2),
//                             fontSize: AppFontSize.labelLarge,
//                             padding: const EdgeInsets.all(AppSpacing.marginS),
//                           )
//                         : Bounce(
//                             duration: const Duration(milliseconds: 200),
//                             onPressed: () {
//                               context.read<ValidateHabitBloc>().add(
//                                   ChangeHabitGoal(
//                                       overallResult.improvedSentence));
//                             },
//                             child: Container(
//                               color: context.isDarkMode
//                                   ? AppColors.darkText
//                                   : AppColors.lightText,
//                               child: ListTile(
//                                 title: Text(
//                                   state.overallResult.improvedSentence,
//                                   overflow: TextOverflow.visible,
//                                 ),
//                                 trailing: const Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: AppColors.grayText,
//                                 ),
//                               ),
//                             ),
//                           ),
//               ],
//             ));
//       },
//     );
//   }
//
//   Widget buildSmartMetrics(
//       OverallAnalysisResult overallResult, TextStyle smartTextStyle) {
//     (IconData, Color) getIconAndColor(double score) {
//       if (overallResult != OverallAnalysisResult.init()) {
//         final percentage = score;
//         if (percentage >= 80) {
//           return (Icons.check_circle, AppColors.success);
//         } else if (percentage >= 50) {
//           return (Icons.warning, AppColors.warning);
//         } else {
//           return (Icons.error, AppColors.error);
//         }
//       } else {
//         return (Icons.remove, AppColors.grayText);
//       }
//     }
//
//     Widget buildMetricRow(String title, double score) {
//       final (icon, color) = getIconAndColor(score);
//       return IconWithText(
//         icon: icon,
//         iconColor: color,
//         text: '$title - ${score.toStringAsFixedWithoutZero()}%',
//         fontSize: smartTextStyle.fontSize,
//         iconSize: smartTextStyle.fontSize,
//         fontWeight: smartTextStyle.fontWeight,
//         fontColor: color,
//         fontStyle: FontStyle.italic,
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildMetricRow(S.current.specify_title, overallResult.specific.score),
//         buildMetricRow(
//             S.current.measurable_title, overallResult.measurable.score),
//         buildMetricRow(
//             S.current.achievable_title, overallResult.achievable.score),
//         buildMetricRow(S.current.relevant_title, overallResult.relevant.score),
//         buildMetricRow(
//             S.current.time_bound_title, overallResult.timeBound.score),
//       ],
//     );
//   }
// }
