const http = require("http");
const dotenv = require("dotenv");
const { Server } = require("ws");

dotenv.config();

const app = require("./api/app");
const pool = require("./configs/db");
const {
  upgradeConnection,
  deleteUserFromSocketConnectionList,
  addUserWebSocket,
  removeUserWSocket
} = require("./websocket/websocket-conn-handle");
const {
  updateUserLastLoggedIN,
  updateUserLastSeen,
  getMyMsgsWithOtherUser,
  insertMsg,
  updateMsgStatusToRead,
  getMyMsgsWithAllFriends
} = require("./websocket/websocket-user-handler");

const port = process.env.PORT || 3000;

pool.connect(async (err, client, release) => {
  if (err) {
    console.error("Error connecting to the database:", err.stack);
  } else {
    release();
    console.log("Connected to the database");
    const server = http.createServer(app);
    const wss = new Server({ server, path: "/connect_to_chat_svc" });
    server.listen(port, () => {
      console.log(`Server listening on port ${port}`);
    });

    server.on("upgrade", (request, socket, head) => {
      upgradeConnection(request, socket, head);
    });

    wss.on("connection", (ws) => {
      ws.on("message", (data) => {
        const parsed = JSON.parse(data);
        const { eventName, payload } = parsed;
        if (eventName === "updateLoggedIn") {
          updateUserLastLoggedIN(ws._socket);
        } else if (eventName === "addUserSocket") {
          addUserWebSocket(ws);
        } else if (eventName === "updateMsgToRead") {
          const fromuserid = payload["fromuserid"];
          const touserid = payload["touserid"];
          updateMsgStatusToRead(fromuserid, touserid);
        } else {
          ws.emit(eventName, ws._socket, payload);
        }
      });

      ws.on("getMsgs", async (socket, payload) => {
        const otherUserId = payload["other_user_id"];
        const result = await getMyMsgsWithOtherUser(socket, otherUserId);
        ws.send(JSON.stringify(result));
      });

      ws.on("insertMsg", async (socket, payload) => {
        const msg = payload["msg"];
        const from_user = payload["from_user_id"];
        const to_user = payload["to_user_id"];
        const result = await insertMsg(msg, from_user, to_user);
        ws.send(JSON.stringify(result));
      });

      ws.on("getMsgsWithAllFriends",async (socket,payload)=>{
        const result = await getMyMsgsWithAllFriends(socket)
        ws.send(JSON.stringify(result))
      })

      ws.on("close", (code, reason) => {
        updateUserLastSeen(ws._socket);
        removeUserWSocket(ws)
        deleteUserFromSocketConnectionList(ws._socket);
      });
    });
  }
});

// notificationListener();
