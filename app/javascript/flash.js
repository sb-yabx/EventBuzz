export function showFlash() {
  const el = document.getElementById("flash-data");
  if (!el) return;

  const flash = JSON.parse(el.dataset.flash || "{}");
  if (Object.keys(flash).length === 0) return;

  if (el.dataset.shown) return;

  Object.entries(flash).forEach(([type, message]) => {
    Swal.fire({
      toast: true,
      position: 'top',
      icon: type === "notice" ? "success" : "error",
      title: message,
      showConfirmButton: false,
      timer: 3000
    });
  });

  el.dataset.shown = "true";
}

