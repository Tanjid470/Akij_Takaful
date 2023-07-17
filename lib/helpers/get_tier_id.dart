int getTierId(String designation) {
  int tierId = 0;

  switch (designation) {
    case 'FA':
      tierId = 1;
      break;
    case 'BM':
      tierId = 2;
      break;
    case 'AGM':
      tierId = 3;
      break;
    case 'DGM':
      tierId = 4;
      break;
    case 'GM':
      tierId = 5;
      break;
    case 'EVP':
      tierId = 6;
      break;
    case 'DMD':
      tierId = 7;
      break;
    default:
      tierId = 0;
  }

  return tierId;
}
