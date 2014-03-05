Package.describe({
  summary: "This package intends to simplify the integration with a Meteor app and the Iugu payment API"
});

Package.on_use(function (api, where) {
  api.add_files('meteor-iugu.js', ['client', 'server']);
});

Package.on_test(function (api) {
  api.use('meteor-iugu');

  api.add_files('meteor-iugu_tests.js', ['client', 'server']);
});
