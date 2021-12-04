// app/javascript/application-esbuild.js
import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
// import "./channels"

import * as bootstrap from "bootstrap"
import "chartkick/chart.js"

require('select2/dist/js/select2')

Rails.start()
ActiveStorage.start()

import "./controllers"

require("trix")
require("@rails/actiontext")

