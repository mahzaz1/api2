class User {
  final String email, gender, phone;
  final UserName name;
  final UserPicture picture;

  User({
    required this.email,
    required this.gender,
    required this.phone,
    required this.picture,
    required this.name
  });
}

class UserName{
  final String title,first,last;
  UserName({
    required this.title,
    required this.first,
    required this.last
  });
}

class UserPicture{
  final String large,medium,thumbnail;
  UserPicture({
    required this.large,
    required this.medium,
    required this.thumbnail
  });
}