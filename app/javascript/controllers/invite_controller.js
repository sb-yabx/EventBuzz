// app/javascript/controllers/invite_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["email", "excel"];

  connect() {
    console.log("Invite controller connected ✅");

    if (!this.hasEmailTarget || !this.hasExcelTarget) return;

    this.emailTarget.addEventListener("input", () => {
      this.excelTarget.disabled = this.emailTarget.value.trim().length > 0;
    });

    this.excelTarget.addEventListener("change", () => {
      this.emailTarget.disabled = this.excelTarget.files.length > 0;
    });
  }
}