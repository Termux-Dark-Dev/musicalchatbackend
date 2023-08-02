const usersConnextedToSocket = new Map(); // this map stores socket as a key and authoken , userid as value
const socketConnectedToUser = new Map(); // this map stores user as key and socket as value so when db event triggers i can see if the to_user(id) is connected to my server using this map as finding will be done in O(1)

exports.removeUser = (socket) => {
  usersConnextedToSocket.delete(socket);
};

exports.addUser = (socket, token, id) => {
  // the socket geeting here is tcp socket and ws._socket is the same tcp socket and not websocket
  usersConnextedToSocket.set(socket, { auth_token: token, user_id: id });
};

exports.addUserSocket = (websocket,id)=>{
  socketConnectedToUser.set(id,websocket)
}

exports.getUserId = (socket) => {
  return usersConnextedToSocket.get(socket).user_id;
};

exports.getUserSocket = (id) => {
  return socketConnectedToUser.get(id);
};

exports.removeUserWebsocket = (id)=>{
  socketConnectedToUser.delete(id);
}