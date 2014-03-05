Package.describe({
  summary: "REPLACEME - What does this package (or the original one you're wrapping) do?"
});

Package.on_use(function (api, where) {
  api.add_files('meteor-iugu.js', ['client', 'server']);
});

Package.on_test(function (api) {
  api.use('meteor-iugu');

  api.add_files('meteor-iugu_tests.js', ['client', 'server']);
});
