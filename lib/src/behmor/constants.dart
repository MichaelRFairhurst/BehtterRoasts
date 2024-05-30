const overheatTemp = 331;
const smokeSuppressorOnTime = Duration(seconds: 7 * 60 + 35);
const smokeSuppressorOffTime = Duration(seconds: 8 * 60 + 30);

// Technically, this is 75% of roast time. This is correct for 1lb P5 roasts.
const pressStartTime = Duration(seconds: 13 * 60 + 30);

const maxRecommendedPreheat = Duration(seconds: 60 + 45);
