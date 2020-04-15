
class NoNetworkException implements Exception {
  @override
  String toString() {
    return 'Aucune connexion internet';
  }
}