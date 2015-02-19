Package.describe({
  summary: "This package intends to simplify the integration with a Meteor app and the Iugu payment API"
});

Package.on_use(function (api, where) {
  api.add_files('server/iugu_api.coffee', ['server']);
  api.add_files('client/iugu.js', ['client']);
});
