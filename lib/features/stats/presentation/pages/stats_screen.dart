import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_up/core/dependency_injectable.dart';
import 'package:focus_up/cubits/ambient_set_cubit/cubit/ambient_set_cubit.dart';
import 'package:focus_up/cubits/listening_history_cubit/cubit/listening_history_cubit.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/stats/presentation/widgets/cosine_similarity.dart';
import 'package:focus_up/l10n/l10n_helper.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AmbientSetCubit>()..fetchAmbientSets(),
        ),
        BlocProvider(
          create:
              (context) =>
                  getIt<ListeningHistoryCubit>()..fetchListeningHistory(),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<AmbientSetCubit, AmbientSetState>(
              builder: (context, state) {
                if (state is AmbientSetLoading) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is AmbientSetLoaded) {
                  final sortedSets = List<AmbientSet>.from(state.ambientSets)
                    ..sort((a, b) => b.playCount.compareTo(a.playCount));

                  log('Sorted Set to charts: //');

                  final favoriteSet =
                      sortedSets.isNotEmpty ? sortedSets.first : null;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                      ),
                      child: Column(
                        children: [
                          if (favoriteSet != null)
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Card(
                                child: ListTile(
                                  leading: Image.network(favoriteSet.image),
                                  title: Text(context.l10n.yourFavoriteSet),
                                  subtitle: Text(
                                    '${favoriteSet.name}\n${context.l10n.played} ${favoriteSet.playCount}',
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: PlayCountChart(
                              sets: sortedSets.take(5).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                log(state.toString());
                return SizedBox.shrink();
              },
            ),
            BlocBuilder<ListeningHistoryCubit, ListeningHistoryState>(
              builder: (context, state) {
                if (state is ListeningHistoryLoading) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is ListeningHistoryLoaded) {
                  final ambientSetState = context.read<AmbientSetCubit>().state;
                  List<AmbientSet> recom = [];
                  if (ambientSetState is AmbientSetLoaded) {
                    recom = CosineSimilarity.getRecommendations(
                      userHistory: state.listeningHistory,
                      allSets: ambientSetState.ambientSets,
                    );
                  }
                  return SizedBox(
                    width: 400,
                    height: 150,
                    child: Card(
                      child: Column(
                        children: [
                          Text(
                            context.l10n.youMightLike,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children:
                                  recom
                                      .map(
                                        (e) => SizedBox(
                                          width: 175,
                                          height: 150,
                                          child: ListTile(
                                            title: Text(e.name, softWrap: true),
                                            leading: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxHeight: 44,
                                                maxWidth: 44,
                                              ),
                                              child: Image.network(
                                                e.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is ListeningHistoryError) {
                  Text(state.message);
                }
                log(state.toString());
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlayCountChart extends StatelessWidget {
  final List<AmbientSet> sets;
  const PlayCountChart({super.key, required this.sets});

  @override
  Widget build(BuildContext context) {
    final barGroups =
        sets.asMap().entries.map((entry) {
          final index = entry.key;
          final set = entry.value;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: set.playCount.toDouble(),
                color: Colors.blue,
                width: 20,
              ),
            ],
          );
        }).toList();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.mostPopularSet,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),

            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: barGroups,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= sets.length) {
                            return SizedBox.shrink();
                          }

                          return Transform.rotate(
                            angle: -0.3,
                            child: Text(
                              sets[index].name,
                              style: TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 1 != 0) return Container();
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 1 != 0) return Container();
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
