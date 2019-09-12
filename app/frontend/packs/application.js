import Rails from "rails-ujs";
import Turbolinks from "turbolinks";

import "../stylesheets/application.css";

function init() {
  Rails.start();
  Turbolinks.start();
}

init();
