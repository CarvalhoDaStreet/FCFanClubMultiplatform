import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fc_fan_club/features/fixtures/domain/entities/fixture.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_bloc.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_event.dart';
import 'package:fc_fan_club/features/fixtures/presentation/bloc/fixtures_state.dart';
import 'package:fc_fan_club/features/fixtures/presentation/widgets/fixture_item_widget.dart';

class FixturesTab extends StatelessWidget {
  final FixturesBloc bloc;
  final List<Fixtures> cachedFixtures;
  final bool isFixturesLoaded;
  final Function(List<Fixtures>) onFixturesLoaded;

  const FixturesTab({
    super.key,
    required this.bloc,
    required this.cachedFixtures,
    required this.isFixturesLoaded,
    required this.onFixturesLoaded,
  });

  @override
  Widget build(BuildContext context) {
    if (!isFixturesLoaded) {
      bloc.add(LoadFixturesEvent(50));
    }

    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<FixturesBloc, FixturesState>(
        builder: (context, state) {
          if (state is FixturesLoading && !isFixturesLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FixturesLoaded) {
            onFixturesLoaded(state.fixtures);
            return ListView.builder(
              itemCount: state.fixtures.length,
              itemBuilder: (context, index) {
                return FixtureItemWidget(fixture: state.fixtures[index]);
              },
            );
          } else if (state is FixturesError && !isFixturesLoaded) {
            return const Center(child: Text('Failed to fetch fixtures'));
          }
          return ListView.builder(
            itemCount: cachedFixtures.length,
            itemBuilder: (context, index) {
              return FixtureItemWidget(fixture: cachedFixtures[index]);
            },
          );
        },
      ),
    );
  }
}
