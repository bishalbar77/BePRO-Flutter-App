import 'package:meta/meta.dart';

class ChatUser {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  ChatUser({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final ChatUser currentUser = ChatUser(
  id: 0,
  name: 'Nick Fury',
  imageUrl: 'assets/images/nick-fury.jpg',
  isOnline: true,
);

// USERS
final ChatUser ironMan = ChatUser(
  id: 1,
  name: 'Iron Man',
  imageUrl: 'assets/images/ironman.jpeg',
  isOnline: true,
);
final ChatUser captainAmerica = ChatUser(
  id: 2,
  name: 'Captain America',
  imageUrl: 'assets/images/captain-america.jpg',
  isOnline: true,
);
final ChatUser hulk = ChatUser(
  id: 3,
  name: 'Hulk',
  imageUrl: 'assets/images/hulk.jpg',
  isOnline: false,
);
final ChatUser scarletWitch = ChatUser(
  id: 4,
  name: 'Scarlet Witch',
  imageUrl: 'assets/images/scarlet-witch.jpg',
  isOnline: false,
);
final ChatUser spiderMan = ChatUser(
  id: 5,
  name: 'Spider Man',
  imageUrl: 'assets/images/spiderman.jpg',
  isOnline: true,
);
final ChatUser blackWindow = ChatUser(
  id: 6,
  name: 'Black Widow',
  imageUrl: 'assets/images/black-widow.jpg',
  isOnline: false,
);
final ChatUser thor = ChatUser(
  id: 7,
  name: 'Thor',
  imageUrl: 'assets/images/thor.png',
  isOnline: false,
);
final ChatUser captainMarvel = ChatUser(
  id: 8,
  name: 'Captain Marvel',
  imageUrl: 'assets/images/captain-marvel.jpg',
  isOnline: false,
);
