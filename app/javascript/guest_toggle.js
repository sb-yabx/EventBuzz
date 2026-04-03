window.toggleGuestSelect = function () {
  const target = document.getElementById("targetSelect").value;
  const guestBox = document.getElementById("guestSelectBox");

  if (target === "individual") {
    guestBox.style.display = "block";
  } else {
    guestBox.style.display = "none";
  }
}