export function chat() {

  console.log("Chat JS loaded")

  const container = document.getElementById("chat-container")
  console.log("Chat container:", container)

  if (!container) return


  const senderType = container.dataset.senderType;
  console.log("Sender type:", senderType)
  const queryId = container.dataset.queryId
  console.log("Query ID:", queryId)
  const channel = window.createQueryChannel(queryId)

  const form = document.getElementById("chat-form")
  const input = document.getElementById("message-input")
  console.log("Input:", input)
  const chatBox = document.getElementById("chat-box")
  console.log("Chat box:", chatBox)

  form.addEventListener("submit", function(e) {
    e.preventDefault()

    console.log("FORM SUBMITTED")  

    const message = input.value
    console.log("Message:", message)
    
    if (message.trim() === "") return

    if (!channel.isConnected) {
  console.log("Waiting for connection...")
  return
}

    channel.perform("send_message", {
      query_id: queryId,
      message: message,
      sender_type: senderType
    })

    input.value = ""
  })
} 