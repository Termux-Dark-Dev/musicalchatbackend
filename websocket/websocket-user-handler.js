const { getUserId, getUserSocket } = require("../websocket-users");
const pool = require("../configs/db");
const crypto = require("crypto");
const moment = require("moment-timezone");

exports.updateUserLastLoggedIN = async (socket) => {
  const id = getUserId(socket);
  pool.query("update users set last_loggedin=$1 where id=$2", [
    moment.tz("Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss"),
    id,
  ]);
};

exports.updateUserLastSeen = async (socket) => {
  const id = getUserId(socket);
  pool.query("update users set last_seen=$1 where id=$2", [
    moment.tz("Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss"),
    id,
  ]);
};

exports.getMyMsgsWithOtherUser = async (socket, otherUserId) => {
  const id = getUserId(socket);
  const { rows } = await pool.query(
    "select messages.*,to_char(messages.created_at, 'YYYY-MM-DD HH24:MI:SS') as formatted_created_at from messages where messages.to_user_id=$1 and messages.from_user_id=$2 or messages.to_user_id=$2 and messages.from_user_id=$1 order by created_at",
    [id, otherUserId]
  );
  await pool.query(
    "update messages set status=$1 where from_user_id=$2 and to_user_id=$3 and status!='read'",
    ["read", otherUserId, id]
  );
  return { msgs: rows, user_id: id };
};

exports.insertMsg = async (msg, from, to) => {
  const randomString = crypto.randomBytes(10).toString("hex");
  const created_at = moment.tz("Asia/Kolkata").format("YYYY-MM-DD HH:mm:ss");
  await pool.query(
    "insert into messages(id,from_user_id,to_user_id,message,created_at,status) values($1,$2,$3,$4,$5,$6)",
    [randomString, from, to, msg, created_at, "pending"]
  );
  const toUsersSocket = getUserSocket(to);
  if (toUsersSocket != undefined || toUsersSocket != null) {
    await pool.query(
      "update messages set status=$1 where to_user_id=$2 and status!='read'",
      ["delivered", to]
    );
    toUsersSocket.send(
      JSON.stringify({
        new_message: {
          msg: msg,
          from_user_id: from,
          to_user_id: to,
          formatted_created_at: created_at,
        },
      })
    );
  }
  return { status: "success" };
};

exports.updateMsgStatusToRead = async (fromuserid, touserid) => {
  await pool.query(
    "update messages set status=$1 where from_user_id=$2 and to_user_id=$3 and status!='read'",
    ["read", fromuserid, touserid]
  );
};

exports.getMyMsgsWithAllFriends = async (socket) => {
  const id = getUserId(socket);
  const { rows } = await pool.query(
    `SELECT messages.from_user_id as friend_id, users.first_name as friend_name,users.profile_pic_url as friend_profile_uri,messages.message as friend_last_msg,to_char(messages.created_at, 'YYYY-MM-DD HH24:MI:SS') as friend_lastmsg_time,messages.status as msg_status
    FROM messages
    JOIN (
        SELECT from_user_id, MAX(created_at) AS max_created_at
        FROM messages
        WHERE to_user_id=$1
        GROUP BY from_user_id
    ) AS last_message
    ON messages.from_user_id = last_message.from_user_id AND messages.created_at = last_message.max_created_at JOIN users
    ON messages.from_user_id = users.id
    WHERE messages.to_user_id=$1`,
    [id]
  );

  return {"friends":rows}
};
