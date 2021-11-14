// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "bootstrap";
import '@fortawesome/fontawesome-free/js/all'
import "@fortawesome/fontawesome-free/css/all.css"

import "chartkick/chart.js"

import JSZip from 'jszip'
require('pdfmake')
// require('datatables.net-bs4')
// require('datatables.net-buttons-bs4')
require('datatables.net-bs5')
require('datatables.net-buttons')
require('datatables.net-buttons-bs5')
require('datatables.net-buttons/js/buttons.colVis.js')
require('datatables.net-buttons/js/buttons.html5.js')
require('datatables.net-buttons/js/buttons.print.js')

require('select2/dist/js/select2')

Rails.start()
ActiveStorage.start()

import "controllers"

require("trix")
require("@rails/actiontext")

