import consumer from "./consumer"

export const createQueryChannel = (queryId) => {
  return consumer.subscriptions.create(
    { channel: "QueryChannel", query_id: queryId },
    {
      received(data) {  
        const chatBox = document.getElementById("chat-box")

        chatBox.innerHTML += `
          <div class="chat-message ${data.sender_type === "admin" ? "admin" : "user"}">
            <div class="chat-bubble">
              <div class="chat-sender">
                ${data.sender_type === "admin" ? "Event Manager" : (data.user_name || "You")}
              </div>
              <div class="chat-text">
                ${data.message}
              </div>
            </div>
          </div>
        `

        chatBox.scrollTop = chatBox.scrollHeight
      }
    }
  )
}

window.createQueryChannel = createQueryChannel