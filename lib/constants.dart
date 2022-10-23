enum TrendingStatus { initial, success, failure }

enum LyricsStatus { initial, success, failure, missing }

const kPageSize = 20;
const kChartName = 'top';
const kHasLyrics = true;
const kMusixMatchApiKey = '<--YOUR-API-HERE-->';
const kMusixMatchApiBaseUrl = 'api.musixmatch.com';
const kMusixMatchApi = '/ws/1.1';

const kSnackbarDuration = Duration(milliseconds: 500);
