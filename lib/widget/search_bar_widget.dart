import 'package:flutter/material.dart';

///定义searchBar的三种样式
///home首页默认状态下使用的样式
///homeLight 首页发生上滑后使用的样式
/// normal 为默认情况下使用的样式
enum SearchBarType { home, normal, homeLight }

class SearchBarWidget extends StatefulWidget {
  ///是否隐藏左侧返回键
  final bool? hideLeft;

  ///搜索框类型
  final SearchBarType searchBarType;

  ///提示文案
  final String? hint;

  ///默认内容
  final String? defaultText;

  ///左侧按钮点击回调
  final void Function()? leftButtonClick;

  /// 中间输入框点击的回调
  final void Function()? inputBoxClick;

  ///右侧按钮点击回调
  final void Function()? rightButtonClick;

  ///输入框点击回调
  ///内容变化的回调
  final ValueChanged<String>? onChanged;

  const SearchBarWidget(
      {super.key,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.inputBoxClick,
      this.rightButtonClick,
      this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClear = false; // 是否显示清除按钮
  final TextEditingController _controller = TextEditingController();

  Widget get _normalSearchBar => Row(
        children: [
          _wrapTap(
              //左侧返回按钮
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: _backBtn,
              ),
              widget.leftButtonClick),
          //搜索输入框
          Expanded(child: _inputBox),
          _wrapTap(
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    '搜索',
                    style: TextStyle(fontSize: 17, color: Colors.blue),
                  )),
              widget.rightButtonClick)
        ],
      );

  get _backBtn => widget.hideLeft ?? false
      ? null
      : const Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
          size: 26,
        );

  get _inputBox {
    Color inputColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputColor = Colors.white;
    } else {
      inputColor = const Color(0xffededed);
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normal
                  ? const Color(0xffa9a9a9)
                  : Colors.blue),
          Expanded(child: _textField),
          if (showClear)
            _wrapTap(
                const Icon(
                  Icons.clear,
                  size: 22,
                  color: Colors.grey,
                ), () {
              setState(() {
                _controller.clear();
              });
              _onChanged('');
            })
        ],
      ),
    );
  }

  ///主页搜索样式
  get _homeSearchBar => Row(
        children: [
          //左边显示的是城市
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(
                  children: [
                    Text(
                      '北京',
                      style: TextStyle(color: _homeFontColor),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor,
                      size: 22,
                    )
                  ],
                ),
              ),
              widget.leftButtonClick),
          // 中间为输入框
          Expanded(child: _inputBox),
          // 登出
          _wrapTap(
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  '登出',
                  style: TextStyle(color: _homeFontColor, fontSize: 12),
                ),
              ),
              widget.rightButtonClick)
        ],
      );

  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;

  ///输入框
  get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
          controller: _controller,
          onChanged: _onChanged,
          autofocus: true,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300),
          //输入框的文本样式
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 5, bottom: 15), // 内容内边距
              border: InputBorder.none,
              hintText: widget.defaultText,
              hintStyle: const TextStyle(fontSize: 15)),
        )
      : _wrapTap(
          Text(
            widget.defaultText ?? '',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          widget.inputBoxClick);

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      _controller.text = widget.defaultText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _normalSearchBar
        : _homeSearchBar;
  }

  _wrapTap(Widget? child, void Function()? callback) {
    return GestureDetector(onTap: callback, child: child);
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}
