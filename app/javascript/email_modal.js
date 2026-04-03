window.currentEvent = {};

window.openEmailModal = function(eventId, eventName, eventDate) {
  const modal = document.getElementById("emailModal");
  const form = document.getElementById("emailForm");

  form.action = `/events/${eventId}/send_custom_email`;

  currentEvent.name = eventName;
  currentEvent.date = eventDate;

  modal.style.display = "flex";
}

window.closeEmailModal = function() {
  document.getElementById("emailModal").style.display = "none";
}

window.previewEmail = function() {
  const subject = document.querySelector('[name="subject"]').value;
  const message = document.querySelector('[name="message"]').value;

  document.getElementById("previewSubject").innerText = subject;

  document.getElementById("previewMessage").innerHTML =
    message.replace(/\n/g, "<br>");

  document.getElementById("previewEvent").innerText = currentEvent.name;
  document.getElementById("previewDate").innerText = currentEvent.date;

  document.getElementById("previewBox").style.display = "block";
}