class Contact {
  final String fullName;
  final String imageUrl;
  final bool isOnline;
  final String lastSeen;

  const Contact(this.fullName, this.imageUrl, this.isOnline,
      {this.lastSeen = ''});

  @override
  String toString() {
    return 'Contact{fullName: $fullName, imageUrl: $imageUrl, isOnline: $isOnline, lastSeen: $lastSeen}';
  }
}
