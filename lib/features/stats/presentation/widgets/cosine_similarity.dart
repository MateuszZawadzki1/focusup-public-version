import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/stats/domain/models/listening_history.dart';

class CosineSimilarity {
  static double calculateSimilarity(
    List<String> userTags,
    List<String> setTags,
  ) {
    if (userTags.isEmpty || setTags.isEmpty) {
      return 0.0;
    }
    final commonTags = userTags.toSet().intersection(setTags.toSet()).length;
    final totalTags = userTags.toSet().union(setTags.toSet()).length;

    return commonTags / totalTags;
  }

  static List<AmbientSet> getRecommendations({
    required List<ListeningHistory> userHistory,
    required List<AmbientSet> allSets,
    int topN = 5,
  }) {
    final tagFrequency = <String, int>{};
    for (var history in userHistory) {
      for (var tag in history.tags) {
        tagFrequency[tag] = (tagFrequency[tag] ?? 0) + 1;
      }
    }
    final alreadyListened = userHistory.map((h) => h.ambientSetId).toSet();

    final recommendations =
        allSets.where((set) => !alreadyListened.contains(set.id)).map((set) {
            final similarity = calculateSimilarity(
              tagFrequency.keys.toList(),
              set.tags ?? [],
            );
            return MapEntry(set, similarity);
          }).toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    return recommendations.take(topN).map((e) => e.key).toList();
  }
}
