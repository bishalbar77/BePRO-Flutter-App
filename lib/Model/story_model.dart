import 'package:meta/meta.dart';
import 'package:YnotV/Model/models.dart';

import 'User.dart';

class Story {
  final User user;
  final String imageUrl;
  final bool isViewed;

  const Story({
    @required this.user,
    @required this.imageUrl,
    this.isViewed = false,
  });
}
