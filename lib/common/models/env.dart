const Map<String, String> environment = <String, String>{
  'baseUrl': 'https://api.themoviedb.org',
  'apiKey': String.fromEnvironment('API_KEY'),
  'streamingBaseUrl': 'https://streaming-availability.p.rapidapi.com',
  'streamingApiKey': String.fromEnvironment('STREAMING_API_KEY'),
};
