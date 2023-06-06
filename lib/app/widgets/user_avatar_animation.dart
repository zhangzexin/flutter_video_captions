import 'package:flutter/material.dart';

class UserAvatarAnimation extends StatefulWidget {
  const UserAvatarAnimation({super.key});

  @override
  State<UserAvatarAnimation> createState() => _UserAvatarAnimationState();
}

class _UserAvatarAnimationState extends State<UserAvatarAnimation>
    with TickerProviderStateMixin {
  /// 会重复播放的控制器
  late final AnimationController _repeatController;

  /// 线性动画
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    /// 动画持续时间是 3秒，此处的this指 TickerProviderStateMixin
    _repeatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // 设置动画重复播放

    // 创建一个从0到360弧度的补间动画 v * 2 * π
    _animation = Tween<double>(begin: 0, end: 1).animate(_repeatController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 45, right: 10),
      child: RotationTransition(
        turns: _animation,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF212121),
            border: Border.all(
              width: 3,
              color: Color(0xFF404040),
            ),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'http://pics5.baidu.com/feed/622762d0f703918f751ba5e950ce8d915beec4c1.jpeg?token=ed435fd18c71cf7ca7a011acb70460f7'),
            ),
          ),
        ),
      ),
    );
  }
}
