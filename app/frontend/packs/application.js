import Rails from "rails-ujs";
import Turbolinks from "turbolinks";

import "bootstrap";
import "@fortawesome/fontawesome-free/js/all";
import "../stylesheets/application.sass";

function init() {
  Rails.start();
  Turbolinks.start();
}

init();
