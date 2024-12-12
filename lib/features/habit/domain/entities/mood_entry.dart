import '../../../../core/enums/mood.dart';

class MoodEntry {
  final DateTime date;
  final Mood mood;

  const MoodEntry({required this.date, required this.mood});
}
