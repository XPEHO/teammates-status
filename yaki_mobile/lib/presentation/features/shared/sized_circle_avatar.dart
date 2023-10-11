import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavIconCircleAvatar extends StatelessWidget {
  final String imageSrc;
  const NavIconCircleAvatar({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: SvgPicture.asset(
        imageSrc,
        width: 20,
        height: 20,
      ),
    );
  }
}

class CellAvatarSvg extends StatelessWidget {
  final String imageSrc;
  const CellAvatarSvg({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: SvgPicture.asset(
        imageSrc,
        width: 48,
        height: 48,
      ),
    );
  }
}

class CellCircleChipSvg extends StatelessWidget {
  final String imageSrc;
  final Color backgroundColor;
  const CellCircleChipSvg({
    super.key,
    required this.imageSrc,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        child: SvgPicture.asset(
          imageSrc,
          height: 11.43,
          width: 11.43,
        ),
      ),
    );
  }
}

class CellIconChipSvgPicture extends StatelessWidget {
  final String imageSrc;
  const CellIconChipSvgPicture({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageSrc,
      width: 16,
      height: 16,
    );
  }
}

class UserDeclarationChipSvgPicture extends StatelessWidget {
  final String imageSrc;
  const UserDeclarationChipSvgPicture({
    super.key,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageSrc,
      width: 32,
      height: 32,
    );
  }
}
