// Entry point
console.log("Hello from app/javascript/application.js!");

import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

// import functions
import { showFlash } from "./flash"
import { initFormToggle } from "./form_toggle"

// import files that attach to window
import "./email_modal"
import "./guest_toggle"
import "./channels"
import { chat } from "./chat"


document.addEventListener("turbo:load", () => {
  chat()
})


// attach functions to window
window.showFlash = showFlash
window.initFormToggle = initFormToggle
window.chat = chat

// run on page load
document.addEventListener("turbo:render", () => {
  showFlash();
  initFormToggle();
});

document.addEventListener("turbo:load", () => {
  showFlash();
  initFormToggle();
});

