import Rails from "rails-ujs";
import Turbolinks from "turbolinks";

import "bootstrap";
import "@fortawesome/fontawesome-free/js/all";
import "../stylesheets/application.sass";

import "../javascripts/utils/toggle_form_field.ts";

function init() {
  Rails.start();
  Turbolinks.start();
}

init();
