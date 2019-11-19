const { environment } = require("@rails/webpacker");
const typescript = require("./loaders/typescript");

environment.loaders.prepend("typescript", typescript);
environment.loaders.get("sass").use.splice(-1, 0, {
  loader: "resolve-url-loader",
  options: {
    attempts: 1
  }
});
environment.config.merge({
  resolve: {
    alias: {
      jquery: "jquery/src/jquery"
    }
  }
});
module.exports = environment;
