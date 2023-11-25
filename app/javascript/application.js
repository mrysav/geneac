import "@hotwired/turbo-rails"
import "./controllers"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

import "./channels"

import "trix"
import "@rails/actiontext"

import "bootstrap"
