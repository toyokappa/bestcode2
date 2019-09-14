import Rails from "rails-ujs";
import Turbolinks from "turbolinks";

import "bootstrap";
import "../stylesheets/application.scss";

function init() {
  Rails.start();
  Turbolinks.start();
}

init();
