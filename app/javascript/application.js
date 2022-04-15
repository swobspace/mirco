// app/javascript/application.js
import "@hotwired/turbo-rails"

import * as ActiveStorage from "@rails/activestorage"
// import "./channels"

import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap

import "chartkick/chart.js"
// import "@fortawesome/fontawesome-free/js/all.js"

// only for direct upload from browser
// ActiveStorage.start()

import "./controllers"

import "trix"
import "@rails/actiontext"

