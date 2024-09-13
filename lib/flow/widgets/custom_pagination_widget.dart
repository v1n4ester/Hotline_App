import 'package:flutter/material.dart';
import 'package:hotline_app/utils/colors.dart';

class CustomPaginationWidget extends StatefulWidget {
  final Function() onLoadMore;
  final Function() onRefresh;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool isSeparated;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  const CustomPaginationWidget(
      {Key? key,
      required this.onLoadMore,
      required this.onRefresh,
      required this.itemCount,
      required this.itemBuilder,
      this.isSeparated = false,
      this.separatorBuilder})
      : super(key: key);

  @override
  State<CustomPaginationWidget> createState() => _CustomPaginationWidgetState();
}

class _CustomPaginationWidgetState extends State<CustomPaginationWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      widget.onLoadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              widget.onRefresh();
            },
            backgroundColor: AppColors.buttonColor,
            color: Colors.white,
            child: widget.isSeparated
                ? ListView.separated(
                    padding: const EdgeInsets.only(bottom: 70),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.itemCount,
                    itemBuilder: widget.itemBuilder,
                    controller: _scrollController,
                    separatorBuilder: widget.separatorBuilder ??
                        (BuildContext context, int index) {
                          return const Divider();
                        },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 70),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.itemCount,
                    itemBuilder: widget.itemBuilder,
                    controller: _scrollController,
                  ),
          ),
        ),
      ],
    );
  }
}