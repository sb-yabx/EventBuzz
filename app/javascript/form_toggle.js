export function initFormToggle() {
  const emailInput = document.getElementById("emails_input");
  const excelInput = document.getElementById("excel_input");

  if (!emailInput || !excelInput) return;

  emailInput.addEventListener("input", function () {
    excelInput.disabled = emailInput.value.trim().length > 0;
  });

  excelInput.addEventListener("change", function () {
    emailInput.disabled = excelInput.files.length > 0;
  });
}