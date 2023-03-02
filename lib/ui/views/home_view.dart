import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/app/domain/services/manage_files_service.dart';
import 'package:tv_randshow/ui/widgets/favorite_list.dart';
import 'package:unicons/unicons.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final ManageFilesService _manageFiles = locator<ManageFilesService>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  translate('app.fav.title'),
                  key: const Key('app.fav.title'),
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              loading
                  ? const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : IconButton(
                      key: const Key('app.fav.save'),
                      tooltip: translate('app.fav.save'),
                      icon: Icon(
                        UniconsLine.file_export,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        setState(() => loading = true);
                        await _manageFiles.saveTvshows();
                        setState(() => loading = false);
                      },
                    )
            ],
          ),
        ),
        const Expanded(child: FavoriteList()),
      ],
    );
  }
}
