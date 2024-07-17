const kToFRatio = 1.8;
const fToKRatio = 5/9;

double fToK(double f) => (f - 32) * fToKRatio + 273.15;
double kToF(double k) => (k - 273.15) * kToFRatio + 32;
