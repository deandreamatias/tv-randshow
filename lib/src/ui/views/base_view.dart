import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../services/service_locator.dart';

class BaseView<T extends Model> extends StatefulWidget {
  const BaseView({ScopedModelDescendantBuilder<T> builder, this.onModelReady})
      : _builder = builder;
  final ScopedModelDescendantBuilder<T> _builder;

  /// Function will be called as soon as the widget is initialized.
  ///
  /// Callback will reive the model that was created and supplied to the ScopedModel
  final Function(T) onModelReady;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Model> extends State<BaseView<T>> {
  final T _model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
        model: _model,
        child: ScopedModelDescendant<T>(
            child: Container(color: Colors.red), builder: widget._builder));
  }
}
