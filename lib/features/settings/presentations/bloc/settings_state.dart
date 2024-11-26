// part of 'settings_cubit.dart';
//
// sealed class SettingsState extends Equatable {
//   final bool isDarkMode;
//   final String language;
//   final String measurementSystem;
//   final DateTime dawn;
//   final DateTime afternoon;
//   final DateTime dusk;
//
//   const SettingsState({
//     required this.isDarkMode,
//     required this.language,
//     required this.measurementSystem,
//     required this.dawn,
//     required this.afternoon,
//     required this.dusk,
//   });
//
//   @override
//   List<Object> get props => [
//         isDarkMode,
//         language,
//         measurementSystem,
//         dawn,
//         afternoon,
//         dusk,
//       ];
// }
//
// final class SettingsInitial extends SettingsState {
//   SettingsInitial()
//       : super(
//           isDarkMode: SettingHelper.isDarkMode,
//           language: LocaleHelper.getDefaultLanguage(),
//           measurementSystem: LocaleHelper.getDefaultMeasurementSystem(),
//         );
// }
//
// final class LanguageChanged extends SettingsState {
//   LanguageChanged(SettingsState current, String language)
//       : super(
//           language: language,
//           isDarkMode: current.isDarkMode,
//           currency: current.currency,
//           temperatureScale: current.temperatureScale,
//           measurementSystem: current.measurementSystem,
//           region: current.region,
//         );
// }
//
// final class ThemeModeChanged extends SettingsState {
//   ThemeModeChanged(SettingsState current, bool isDarkMode)
//       : super(
//           language: current.language,
//           isDarkMode: isDarkMode,
//           currency: current.currency,
//           temperatureScale: current.temperatureScale,
//           measurementSystem: current.measurementSystem,
//           region: current.region,
//         );
// }
//
// final class CurrencyChanged extends SettingsState {
//   CurrencyChanged(SettingsState current, String currency)
//       : super(
//           language: current.language,
//           isDarkMode: current.isDarkMode,
//           currency: currency,
//           temperatureScale: current.temperatureScale,
//           measurementSystem: current.measurementSystem,
//           region: current.region,
//         );
// }
//
// final class MeasurementSystemChanged extends SettingsState {
//   MeasurementSystemChanged(SettingsState current, String measurementSystem)
//       : super(
//           language: current.language,
//           isDarkMode: current.isDarkMode,
//           currency: current.currency,
//           temperatureScale: current.temperatureScale,
//           measurementSystem: measurementSystem,
//           region: current.region,
//         );
// }
//
// final class TemperatureScaleChanged extends SettingsState {
//   TemperatureScaleChanged(SettingsState current, String temperatureScale)
//       : super(
//           language: current.language,
//           isDarkMode: current.isDarkMode,
//           currency: current.currency,
//           temperatureScale: temperatureScale,
//           measurementSystem: current.measurementSystem,
//           region: current.region,
//         );
// }
