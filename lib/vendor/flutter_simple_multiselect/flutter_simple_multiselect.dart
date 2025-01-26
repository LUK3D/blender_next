import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/foundation.dart';
import './suggestions_box_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'dart:developer' as developer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'flutter_multiselect_layout_delegate.dart';
import 'flutter_multiselect_layout.dart';

typedef SuggestionBuilder<T> = Widget Function(
    BuildContext context, FlutterMultiselectState<T> state, T data);
typedef InputSuggestions<T> = FutureOr<List<T>> Function(String query);
typedef SearchSuggestions<T> = FutureOr<List<T>> Function();

/// A [Widget] for editing tag similar to Google's Gmail
/// email address input widget in the iOS app.
class FlutterMultiselect<T> extends StatefulWidget {
  const FlutterMultiselect({
    required this.length,
    this.minTextFieldWidth = 160.0,
    this.tagSpacing = 4.0,
    required this.tagBuilder,
    required this.suggestionBuilder,
    required this.findSuggestions,
    super.key,
    this.focusNode,
    this.isLoading = false,
    this.enabled = true,
    this.controller,
    this.textStyle,
    this.inputDecoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.maxLines = 1,
    this.resetTextOnSubmitted = false,
    this.onSubmitted,
    this.inputFormatters,
    this.keyboardAppearance,
    this.suggestionsBoxMaxHeight,
    this.suggestionsBoxElevation,
    this.suggestionsBoxBackgroundColor,
    this.suggestionsBoxRadius,
    this.debounceDuration,
    this.activateSuggestionBox = true,
    this.cursorColor,
    this.backgroundColor,
    this.focusedBorderColor,
    this.enableBorderColor,
    this.borderRadius,
    this.borderSize,
    this.padding,
    this.suggestionPadding,
    this.autoDisposeFocusNode = true,
    this.multiselect = true,
    this.validator,
    this.errorStyling,
    this.errorBorderColor,
    this.suggestionMargin,
    this.collapsedHeight,
    this.unfocusedInputDecoration,
    this.leadingSelectionPadding,
  });

  /// Multiple choices
  final bool multiselect;

  /// The number of tags currently shown.
  final int length;

  /// The minimum width that the `TextField` should take
  final double minTextFieldWidth;

  /// The spacing between each tag
  final double tagSpacing;

  /// Builder for building the tags, this usually use Flutter's Material `Chip`.
  final Widget Function(BuildContext, int) tagBuilder;

  /// Loader for async fetching
  final bool isLoading;

  /// Reset the TextField when `onSubmitted` is called
  /// this is default to `false` because when the form is submitted
  /// usually the outstanding value is just used, but this option is here
  /// in case you want to reset it for any reasons (like converting the
  /// outstanding value to tag).
  final bool resetTextOnSubmitted;

  /// Called when the user are done editing the text in the [TextField]
  /// Use this to get the outstanding text that aren't converted to tag yet
  /// If no text is entered when this is called an empty string will be passed.
  final ValueChanged<String>? onSubmitted;

  /// Focus node for checking if the [TextField] is focused.
  final FocusNode? focusNode;

  /// [TextFormField]'s properties.
  ///
  /// Please refer to [TextFormField] documentation.
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? textStyle;
  final InputDecoration? inputDecoration;
  final InputDecoration? unfocusedInputDecoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool autocorrect;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Brightness? keyboardAppearance;
  final Color? cursorColor;
  final Color? backgroundColor;
  final Color? focusedBorderColor;
  final Color? enableBorderColor;
  final double? borderRadius;
  final double? borderSize;
  final EdgeInsets? padding;
  final bool autoDisposeFocusNode;
  final String? Function(dynamic)? validator;

  /// [SuggestionBox]'s properties.
  final double? suggestionsBoxMaxHeight;
  final double? suggestionsBoxElevation;
  final SuggestionBuilder<T> suggestionBuilder;
  final InputSuggestions<T> findSuggestions;
  final Color? suggestionsBoxBackgroundColor;
  final double? suggestionsBoxRadius;
  final Duration? debounceDuration;
  final bool activateSuggestionBox;
  final EdgeInsets? suggestionMargin;
  final EdgeInsets? suggestionPadding;
  final TextStyle? errorStyling;
  final Color? errorBorderColor;

  final double? collapsedHeight;
  final double? leadingSelectionPadding;

  @override
  FlutterMultiselectState<T> createState() => FlutterMultiselectState<T>();
}

class FlutterMultiselectState<T> extends State<FlutterMultiselect<T>> {
  /// A controller to keep value of the [TextField].
  late TextEditingController _textFieldController;
  String? formError;

  /// A state variable for checking if new text is enter.
  var _previousText = '';

  /// A state for checking if the [TextFiled] has focus.
  var _isFocused = false;

  /// Focus node for checking if the [TextField] is focused.
  late FocusNode _focusNode;

  StreamController<List<T>?>? _suggestionsStreamController;
  SuggestionsBoxController? _suggestionsBoxController;
  final _layerLink = LayerLink();
  List<T>? _suggestions;
  int _searchId = 0;
  Debouncer? _deBouncer;
  final textFormKey = GlobalKey();
  double inputHeight = 24;

  RenderBox? get renderBox => context.findRenderObject() as RenderBox?;

  @override
  void initState() {
    super.initState();
    _textFieldController = (widget.controller ?? TextEditingController());

    _focusNode = (widget.focusNode ?? FocusNode())
      ..addListener(_onFocusChanged);
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (textFormKey.currentContext != null &&
          textFormKey.currentContext!.size != null) {
        setState(() {
          inputHeight = textFormKey.currentContext!.size!.height;
        });
      }
    });

    if (widget.activateSuggestionBox) _initializeSuggestionBox();
  }

  @override
  void dispose() {
    developer.log('FlutterMultiselectState::dispose():');
    if (widget.autoDisposeFocusNode || widget.focusNode == null) {
      _focusNode.removeListener(_onFocusChanged);
      _focusNode.dispose();
    }
    _suggestionsStreamController?.close();
    _suggestionsBoxController?.close();
    super.dispose();
  }

  void _initializeSuggestionBox() {
    _deBouncer = Debouncer<String>(
        widget.debounceDuration ?? const Duration(milliseconds: 300),
        initialValue: '');

    _deBouncer?.values.listen((value) {
      _onSearchChanged(value);
    });

    _suggestionsBoxController = SuggestionsBoxController(context);
    _suggestionsStreamController = StreamController<List<T>?>.broadcast();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _createOverlayEntry();
    });
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _scrollToVisible();
      _onSearchChanged("");
      setState(() {
        formError = null;
      });
      _suggestionsBoxController?.open();
    } else {
      _suggestionsBoxController?.close();
    }

    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _createOverlayEntry() {
    _suggestionsBoxController?.overlayEntry = OverlayEntry(
      builder: (context) {
        if (renderBox != null) {
          final size = renderBox!.size;
          final renderBoxOffset = renderBox!.localToGlobal(Offset.zero);
          final topAvailableSpace = renderBoxOffset.dy;
          final mq = MediaQuery.of(context);
          final bottomAvailableSpace = mq.size.height -
              mq.viewInsets.bottom -
              renderBoxOffset.dy -
              size.height;
          var suggestionBoxHeight =
              max(topAvailableSpace, bottomAvailableSpace);
          if (null != widget.suggestionsBoxMaxHeight) {
            suggestionBoxHeight =
                min(suggestionBoxHeight, widget.suggestionsBoxMaxHeight!);
          }
          final showTop = topAvailableSpace > bottomAvailableSpace;
          final compositedTransformFollowerOffset =
              showTop ? Offset(0, -size.height) : Offset.zero;

          return StreamBuilder<List<T>?>(
            stream: _suggestionsStreamController?.stream,
            initialData: _suggestions,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final suggestionsListView = PointerInterceptor(
                  child: Padding(
                    padding: widget.suggestionMargin ?? EdgeInsets.zero,
                    child: Material(
                      elevation: widget.suggestionsBoxElevation ?? 20,
                      borderRadius: BorderRadius.circular(
                        widget.suggestionsBoxRadius ?? 20,
                      ),
                      color: widget.suggestionsBoxBackgroundColor ??
                          Colors.transparent,
                      child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: widget.suggestionsBoxBackgroundColor ??
                                Colors.transparent,
                            borderRadius: showTop
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(
                                        widget.suggestionsBoxRadius ?? 0),
                                    topRight: Radius.circular(
                                        widget.suggestionsBoxRadius ?? 0),
                                  )
                                : BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        widget.suggestionsBoxRadius ?? 0),
                                    bottomRight: Radius.circular(
                                        widget.suggestionsBoxRadius ?? 0),
                                  ),
                          ),
                          constraints:
                              BoxConstraints(maxHeight: suggestionBoxHeight),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding:
                                widget.suggestionPadding ?? EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return _suggestions != null &&
                                      _suggestions?.isNotEmpty == true
                                  ? widget.suggestionBuilder(
                                      context, this, _suggestions![index]!)
                                  : Container();
                            },
                          )),
                    ),
                  ),
                );
                return Positioned(
                  width: size.width,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: compositedTransformFollowerOffset,
                    child: !showTop
                        ? suggestionsListView
                        : FractionalTranslation(
                            translation: const Offset(0, -1),
                            child: suggestionsListView,
                          ),
                  ),
                );
              }
              return Container();
            },
          );
        }
        return Container();
      },
    );
  }

  void _onTextFieldChange(String string) {
    if (string != _previousText) {
      _deBouncer?.value = string;
    }

    _previousText = string;

    if (string.isEmpty) {
      return;
    }
  }

  void _onSearchChanged(String value) async {
    final localId = ++_searchId;
    _suggestionsBoxController?.close();
    setState(() => _suggestions = []);
    final results = await widget.findSuggestions(value);
    if (_searchId == localId && mounted) {
      setState(() => _suggestions = results);
    }
    _suggestionsStreamController?.add(_suggestions ?? []);
    if (!(_suggestionsBoxController?.isOpened == true)) {
      _suggestionsBoxController?.open();
    }
  }

  void _scrollToVisible() {
    Future.delayed(const Duration(milliseconds: 300), () {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final renderBox = context.findRenderObject() as RenderBox;
        await Scrollable.of(context).position.ensureVisible(renderBox);
      });
    });
  }

  void selectAndClose(T data, [newString]) {
    _suggestions = null;
    _suggestionsStreamController?.add([]);
    if (widget.multiselect) {
      _resetTextField();
    } else {
      _textFieldController.text = newString ?? "";
    }
  }

  void _onSubmitted(String string) {
    widget.onSubmitted?.call(string);
    if (widget.resetTextOnSubmitted && widget.multiselect) {
      _resetTextField();
    }
  }

  void _resetTextField() {
    _textFieldController.text = '';
    _previousText = '';
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < (kIsWeb ? 509 : 520);
    InputDecoration customDec = widget.inputDecoration ??
        InputDecoration(
          errorBorder: widget.multiselect
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0.01,
                  ))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0.01,
                  )),
          errorStyle: const TextStyle(height: 0.01, color: Colors.transparent),
          isDense: true,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
              )),
          hintText: AppLocalizations.of(context)!.typeToSearch,
        );
    final decoration = widget.isLoading
        ? customDec.copyWith(
            suffixIcon: Container(
            width: 4,
            height: 4,
            padding: const EdgeInsets.all(15),
            child: const CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ))
        : customDec;

    final flutterMultiselectArea = GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
        setState(() {
          _isFocused = true;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: widget.padding != null && widget.length > 0
                ? widget.padding
                : EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius ?? 0)),
                border: Border.all(
                    width: widget.borderSize ?? (_isFocused ? 1 : 0.5),
                    color: _isFocused
                        ? widget.focusedBorderColor ?? Colors.transparent
                        : (formError != null)
                            ? (widget.errorBorderColor ??
                                Theme.of(context).colorScheme.error)
                            : (widget.enableBorderColor ?? Colors.transparent)),
                color: widget.backgroundColor ?? Colors.transparent),
            child: FlutterMultiselectLayout(
              delegate: FlutterMultiselectLayoutDelegate(
                  length: widget.length,
                  minTextFieldWidth: widget.minTextFieldWidth,
                  spacing: widget.tagSpacing,
                  position: Offset.zero),
              children: [
                if (widget.multiselect)
                  ...List<Widget>.generate(
                    widget.length,
                    (index) => LayoutId(
                      id: FlutterMultiselectLayoutDelegate.getTagId(index),
                      child: Padding(
                          padding: kIsWeb || Platform.isMacOS
                              ? const EdgeInsets.only(top: 3)
                              : (Platform.isAndroid || Platform.isIOS
                                  ? EdgeInsets.zero
                                  : const EdgeInsets.only(top: 3)),
                          child: widget.tagBuilder(context, index)),
                    ),
                  ),
                LayoutId(
                    id: FlutterMultiselectLayoutDelegate.textFieldId,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: widget.multiselect
                          ? TextFormField(
                              key: textFormKey,
                              onTap: () {
                                if (_isFocused) {
                                  _onSearchChanged("");
                                }
                              },
                              validator: (value) {
                                if (widget.validator == null) {
                                  return null;
                                }
                                setState(() {
                                  formError = widget.validator!(value);
                                });
                                return widget.validator!(value);
                              },
                              style: widget.textStyle,
                              focusNode: _focusNode,
                              enabled: widget.enabled,
                              controller: _textFieldController,
                              keyboardType: widget.keyboardType,
                              keyboardAppearance: widget.keyboardAppearance,
                              textCapitalization: widget.textCapitalization,
                              textInputAction: widget.textInputAction,
                              cursorColor: widget.cursorColor,
                              autocorrect: widget.autocorrect,
                              textAlign: widget.textAlign,
                              textDirection: widget.textDirection,
                              readOnly: widget.readOnly,
                              autofocus: widget.autofocus,
                              maxLines: widget.maxLines,
                              decoration:
                                  decoration.copyWith(border: InputBorder.none),
                              onChanged: _onTextFieldChange,
                              onFieldSubmitted: _onSubmitted,
                              inputFormatters: widget.inputFormatters,
                            )
                          : TextFormField(
                              onTap: () {
                                if (_isFocused) {
                                  _onSearchChanged("");
                                }
                              },
                              validator: (value) {
                                if (widget.validator == null) {
                                  return null;
                                }
                                setState(() {
                                  formError = widget.validator!(value);
                                });
                                return widget.validator!(value);
                              },
                              style: widget.textStyle,
                              focusNode: _focusNode,
                              enabled: widget.enabled,
                              controller: _textFieldController,
                              keyboardType: widget.keyboardType,
                              keyboardAppearance: widget.keyboardAppearance,
                              textCapitalization: widget.textCapitalization,
                              textInputAction: widget.textInputAction,
                              cursorColor: widget.cursorColor,
                              autocorrect: widget.autocorrect,
                              textAlign: widget.textAlign,
                              textDirection: widget.textDirection,
                              readOnly: widget.readOnly,
                              autofocus: widget.autofocus,
                              maxLines: widget.maxLines,
                              decoration:
                                  decoration.copyWith(border: InputBorder.none),
                              onChanged: _onTextFieldChange,
                              onFieldSubmitted: _onSubmitted,
                              inputFormatters: widget.inputFormatters,
                            ),
                    )),
              ],
            ),
          ),
          if (formError != null)
            Padding(
                padding: const EdgeInsets.only(top: 7, left: 20),
                child: Text(
                  formError.toString(),
                  style: widget.errorStyling ??
                      Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                ))
        ],
      ),
    );

    Widget? itemChild;

    itemChild = flutterMultiselectArea;

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (SizeChangedLayoutNotification val) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _suggestionsBoxController?.overlayEntry?.markNeedsBuild();
        });
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            itemChild,
            CompositedTransformTarget(
              link: _layerLink,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
