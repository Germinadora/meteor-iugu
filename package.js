Iugu = this.Iugu

Package.describe({
  summary: "This package intends to simplify the integration with a Meteor app and the Iugu payment API",
  version: "0.0.4",
  name: "germinadora:iugu",
  git: "https://github.com/Germinadora/meteor-iugu.git"
});

Package.on_use(function (api, where) {
  api.versionsFrom('0.9.0');
  api.use("coffeescript", "client");
  api.export('Iugu', 'server');
  api.export('Iugu', 'client');
  api.add_files('server/iugu_api.coffee', 'server');
  api.add_files('client/iugu.js', 'client');
});
