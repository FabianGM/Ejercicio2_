function fn() {
  var config = {
    baseUrl: 'https://petstore.swagger.io/v2'
  };
  karate.configure('ssl', true);
  return config;
}