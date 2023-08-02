const jwt = require("jsonwebtoken");
const {
  addUser,
  removeUser,
  getUserId,
  addUserSocket,
  removeUserWebsocket
} = require("../websocket-users");

exports.upgradeConnection = (request, socket, head) => {
  const token = request.headers.authorization?.split(" ")[1];
  if (token === undefined) {
    // Send a close frame with status code 1008 (Policy Violation) and a reason
    socket.write(
      "HTTP/1.1 401 Unauthorized\r\n" +
        "Sec-WebSocket-Version: 13\r\n" +
        "Content-Type: text/plain; charset=UTF-8\r\n" +
        "Content-Length: 12\r\n" +
        "\r\n" +
        "Unauthorized"
    );
    socket.end();
    return;
  }
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);
    addUser(socket, token, decoded["id"]);
  } catch (error) {
    socket.write(
      "HTTP/1.1 401 Unauthorized\r\n" +
        "Sec-WebSocket-Version: 13\r\n" +
        "Content-Type: text/plain; charset=UTF-8\r\n" +
        "Content-Length: 12\r\n" +
        "\r\n" +
        "Unauthorized"
    );
    socket.end();
  }
};

exports.addUserWebSocket = (websocket) => {
  const id = getUserId(websocket._socket);
  addUserSocket(websocket, id);
};

exports.deleteUserFromSocketConnectionList = (socket) => {
  removeUser(socket);
  return;
};

exports.removeUserWSocket = (websocket) =>{
  const id = getUserId(websocket._socket);
  removeUserWebsocket(id);
}