class SiteApp {
  final int id;
  final String user;
  final String url;
  final String password;
  String? obs;

  SiteApp(
      {required this.id,
      required this.user,
      required this.url,
      required this.password,
      this.obs});
  Map<String, Object?> toMap() {
    return {'id ': id, 'user': user, 'url': url, 'password': password};
  }

  @override
  String toString() {
    return 'Site/App{ID: $id, url: $url, user: $user, password: $password}';
  }
}
