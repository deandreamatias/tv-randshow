import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/models/result.dart';
import '../../core/viewmodels/views/search_view_model.dart';
import '../base_widget.dart';
import '../shared/unicons_icons.dart';
import '../widgets/search_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController textEditingController;
  PagewiseLoadController<Result> _pageLoadController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _pageLoadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SearchViewModel>(
      model: SearchViewModel(
        apiService: Provider.of(context),
      ),
      onModelReady: (SearchViewModel model) {
        _pageLoadController = PagewiseLoadController<Result>(
          pageSize: 20,
          pageFuture: (int page) => model.loadList(
            textEditingController.text,
            page + 1,
            LocalizedApp.of(context)
                .delegate
                .currentLocale
                .languageCode
                .toString(),
          ),
        );
      },
      builder: (BuildContext context, SearchViewModel model, Widget child) =>
          Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: textEditingController,
                textInputAction: TextInputAction.search,
                onSubmitted: (String value) =>
                    textEditingController.text.isNotEmpty
                        ? _pageLoadController.reset()
                        : null,
                autofocus: true,
                autocorrect: true,
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: translate('app.search.search_bar'),
                  prefixIcon: const Icon(Unicons.search),
                ),
              ),
            ),
            Expanded(
              child: PagewiseGridView<Result>.extent(
                pageLoadController: _pageLoadController,
                physics: const BouncingScrollPhysics(),
                maxCrossAxisExtent: 180.0,
                childAspectRatio: 0.8,
                showRetry: false,
                padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                errorBuilder: (BuildContext context, Object dyna) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        translate('app.search.error_message'),
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                noItemsFoundBuilder: (BuildContext context) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        translate(
                          textEditingController.text.isEmpty
                              ? 'app.search.init_message'
                              : 'app.search.empty_message',
                        ),
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                itemBuilder: (BuildContext context, dynamic item, int index) =>
                    SearchWidget(result: item),
                loadingBuilder: (BuildContext context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
