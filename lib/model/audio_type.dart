enum AudioType {
  abdullahAlJuhany(
      jsonId: '01', name: 'Abdullah Al-Juhany', urlPart: 'Abdullah-Al-Juhany'),
  abdulMuhsinAlQasim(
      jsonId: '02',
      name: 'Abdul Muhsin Al Qasim',
      urlPart: 'Abdul-Muhsin-Al-Qasim'),
  abdurrahmanAsSudais(
      jsonId: '03',
      name: 'Abdurrahman As-Sudais',
      urlPart: 'Abdurrahman-as-Sudais'),
  ibrahimAlDossari(
      jsonId: '04', name: 'Ibrahim Al-Dossari', urlPart: 'Ibrahim-Al-Dossari'),
  misyariRasyid(
      jsonId: '05', name: 'Misyari Rasyid', urlPart: 'Misyari-Rasyid-Al-Afasy');

  const AudioType({
    required this.name,
    required this.urlPart,
    required this.jsonId,
  });

  final String name;
  final String urlPart;
  final String jsonId;
}
