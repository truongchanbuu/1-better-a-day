part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  final bool isDarkMode;
  final String language;
  final String measurementSystem;
  final String dawn;
  final String afternoon;
  final String dusk;

  const SettingsState({
    required this.isDarkMode,
    required this.language,
    required this.measurementSystem,
    required this.dawn,
    required this.afternoon,
    required this.dusk,
  });

  @override
  List<Object> get props => [
        isDarkMode,
        language,
        measurementSystem,
        dawn,
        afternoon,
        dusk,
      ];
}

final class SettingsInitial extends SettingsState {
  SettingsInitial()
      : super(
          isDarkMode: SettingHelper.isDarkMode,
          language: SettingHelper.langCode,
          measurementSystem: SettingHelper.measurementSystem,
          dawn: SettingHelper.dawn,
          afternoon: SettingHelper.afternoon,
          dusk: SettingHelper.dusk,
        );
}

final class LanguageChanged extends SettingsState {
  LanguageChanged(SettingsState current, String language)
      : super(
          isDarkMode: current.isDarkMode,
          language: language,
          measurementSystem: current.measurementSystem,
          dawn: current.dawn,
          afternoon: current.afternoon,
          dusk: current.dusk,
        );
}

final class ThemeModeChanged extends SettingsState {
  ThemeModeChanged(SettingsState current, bool isDarkMode)
      : super(
          isDarkMode: isDarkMode,
          language: current.language,
          measurementSystem: current.measurementSystem,
          dawn: current.dawn,
          afternoon: current.afternoon,
          dusk: current.dusk,
        );
}

final class MeasurementSystemChanged extends SettingsState {
  MeasurementSystemChanged(SettingsState current, String measurementSystem)
      : super(
          isDarkMode: current.isDarkMode,
          language: current.language,
          measurementSystem: measurementSystem,
          dawn: current.dawn,
          afternoon: current.afternoon,
          dusk: current.dusk,
        );
}

class TimeChanged extends SettingsState {
  TimeChanged(
    SettingsState current, {
    String? dawn,
    String? afternoon,
    String? dusk,
  }) : super(
          isDarkMode: current.isDarkMode,
          language: current.language,
          measurementSystem: current.measurementSystem,
          dawn: dawn ?? current.dawn,
          afternoon: afternoon ?? current.afternoon,
          dusk: dusk ?? current.dusk,
        );
}
