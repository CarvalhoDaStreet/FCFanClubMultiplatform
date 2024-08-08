import 'package:fc_fan_club/features/fixtures/presentation/widgets/results_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_bloc.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/results/results_state.dart';

class ResultsTab extends StatelessWidget {
  final ResultsBloc bloc;
  final List<Fixtures> cachedResults;
  final bool isResultsLoaded;
  final Function(List<Fixtures>) onResultsLoaded;

  const ResultsTab({
    super.key,
    required this.bloc,
    required this.cachedResults,
    required this.isResultsLoaded,
    required this.onResultsLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ResultsBloc, ResultsState>(
        builder: (context, state) {
          if (state is ResultsLoading && !isResultsLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResultsLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onResultsLoaded(state.results);
            });
            return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return ResultItemWidget(fixture: state.results[index]);
              },
            );
          } else if (state is ResultsError && !isResultsLoaded) {
            return const Center(child: Text('Failed to fetch results'));
          }
          return ListView.builder(
            itemCount: cachedResults.length,
            itemBuilder: (context, index) {
              return ResultItemWidget(fixture: cachedResults[index]);
            },
          );
        },
      ),
    );
  }
}
