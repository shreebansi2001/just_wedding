import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import 'app_text_field.dart';

class AppSearchField extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final Duration debounceDuration;

  const AppSearchField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  Timer? _debounce;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      hintText: widget.hintText,
      prefixIcon: const Icon(Icons.search, color: AppColors.hint, size: 20),
      suffixIcon: _controller.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear, color: AppColors.hint, size: 18),
              onPressed: () {
                _controller.clear();
                _onSearchChanged('');
                setState(() {});
              },
            )
          : null,
      onChanged: (val) {
        _onSearchChanged(val);
        setState(() {});
      },
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'^\s')), // Deny space at start
      ],
    );
  }
}
