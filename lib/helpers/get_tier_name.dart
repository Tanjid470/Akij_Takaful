String getTierName(int tierId) {
  String tierName = "";

  switch (tierId) {
    case 1:
      tierName = 'FA';
      break;
    case 2:
      tierName = 'BM';
      break;
    case 3:
      tierName = 'AGM';
      break;
    case 4:
      tierName = 'DGM';
      break;
    case 5:
      tierName = 'GM';
      break;
    case 6:
      tierName = 'EVP';
      break;
    case 7:
      tierName = 'DMD';
      break;
    default:
      tierName = "";
  }

  return tierName;
}
