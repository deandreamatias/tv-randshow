import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';

import '../../core/models/result.dart';
import '../../core/viewmodels/views/search_view_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';
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
        secureStorageService: Provider.of(context),
      ),
      onModelReady: (SearchViewModel model) {
        // TODO: First time load first message or popular tv show list
        _pageLoadController = PagewiseLoadController<Result>(
          pageSize: 20,
          pageFuture: (int page) {
            return model.loadList(
              textEditingController.text,
              page + 1,
              FlutterI18n.currentLocale(context).languageCode.toString(),
            );
          },
        );
      },
      builder: (BuildContext context, SearchViewModel model, Widget child) =>
          Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      hintText: FlutterI18n.translate(
                          context, 'app.search.search_bar'),
                      contentPadding: const EdgeInsets.all(0.0),
                      // TODO: Implement clean search when press in suffix icon
                      //suffixIcon: Icon(Icons.close),
                      prefixIcon:
                          const Icon(Unicons.search, color: StyleColor.PRIMARY),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: StyleColor.PRIMARY),
                          borderRadius: BORDER_RADIUS),
                      border:
                          const OutlineInputBorder(borderRadius: BORDER_RADIUS),
                    ),
                  ),
                ),
                Expanded(
                  child: PagewiseGridView<Result>.count(
                    pageLoadController: _pageLoadController,
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    showRetry: false,
                    padding: DEFAULT_INSESTS,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    errorBuilder: (BuildContext context, Object dyna) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            FlutterI18n.translate(
                                context, 'app.search.error_message'),
                            style: StyleText.MESSAGES,
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
                            FlutterI18n.translate(
                                context, 'app.search.empty_message'),
                            style: StyleText.MESSAGES,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    itemBuilder:
                        (BuildContext context, dynamic item, int index) =>
                            SearchWidget(result: item),
                    loadingBuilder: (BuildContext context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
