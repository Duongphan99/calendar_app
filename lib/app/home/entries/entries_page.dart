import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/home/entries/entries_bloc.dart';
import 'package:flutter_time_app/app/home/entries/entries_list_tile.dart';
import 'package:flutter_time_app/app/home/jobs/list_item_builder.dart';
import 'package:flutter_time_app/services/database.dart';
import 'package:provider/provider.dart';

class EntriesPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Provider<EntriesBloc>(
      create: (_) => EntriesBloc(database: database),
      child: EntriesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entries'),
        elevation: 2.0,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final bloc = Provider.of<EntriesBloc>(context, listen: false);
    return StreamBuilder<List<EntriesListTileModel>>(
      stream: bloc.entriesTileModelStream,
      builder: (context, snapshot) {
        return ListItemBuider<EntriesListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => EntriesListTile(model: model),
        );
      },
    );
  }
}