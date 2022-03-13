// app/javascript/application-esbuild.js
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
// import "./channels"

import * as bootstrap from "bootstrap"
import "chartkick/chart.js"

// only for direct upload from browser
// ActiveStorage.start()

import "./controllers"

import "trix"
import "@rails/actiontext"

