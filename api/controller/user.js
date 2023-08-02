const pool = require("../../configs/db");
const crypto = require("crypto");
const jwt = require("jsonwebtoken");
const fs = require("fs");
const path = require("path");

exports.checkUserExists = async (req, res, next) => {
  try {
    if (req.body.spotify_id === undefined) {
      return res.status(400).json({
        missing_parameters: "spotify_id",
      });
    }

    var { rowCount, rows } = await pool.query(
      "select id from users where users.spotify_id=$1",
      [req.body.spotify_id]
    );

    req.rowCount = rowCount;

    if (rowCount > 0) {
      req.UserId = rows[0]["id"];
    }
    next();
  } catch (error) {
    const myerror = new Error("Error while verifying user");
    myerror.status = 500;
    myerror.stack = error;
    next(myerror);
  }
};

exports.signUpUser = async (req, res, next) => {
  const client = await pool.connect();
  try {
    const requiredParams = [
      "spotify_id",
      "first_name",
      "last_name",
      "sex",
      "dob",
      "age",
      "phone_num",
      "reg_date",
      "top_artist_array",
      "top_genre_array",
    ];
    const missingParams = requiredParams.filter(
      (param) => req.body[param] === undefined
    );

    if (missingParams.length > 0) {
      // Send a message to the user indicating which parameters are missing
      res.status(400).json({
        missing_parameters: `${missingParams.join(", ")}`,
      });
    } else {
      const randomString = crypto.randomBytes(10).toString("hex");
      await client.query("BEGIN");
      var { rowCount, rows } = await client.query(
        `insert into users(id,spotify_id,first_name,last_name,sex,dob,age,phone_num,registration_date,profile_pic_url) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING id`,
        [
          randomString,
          req.body.spotify_id,
          req.body.first_name,
          req.body.last_name,
          req.body.sex,
          req.body.dob,
          req.body.age,
          req.body.phone_num,
          req.body.reg_date,
          "http://192.168.0.105:9000/" + req.file.path,
        ]
      );

      var result = await client.query(
        "insert into song_stats(user_id,top_artists,top_genre) values($1,$2,$3)",
        [randomString, req.body.top_artist_array, req.body.top_genre_array]
      );

      await client.query("COMMIT");

      if (rowCount > 0 && result.rowCount > 0) {
        res.status(201).json({
          message: "User created",
          token: jwt.sign({ id: rows[0].id }, process.env.JWT_SECRET_KEY, {
            expiresIn: "1y",
          }),
        });
      } else {
        await client.query("ROLLBACK");
        res.status(500).json({
          message: "Internal server error",
        });
      }
    }
  } catch (error) {
    await client.query("ROLLBACK");
    const myerror = new Error("Error while registering user");
    myerror.status = 500;
    myerror.stack = error;
    next(myerror);
  } finally {
    client.release();
  }
};

exports.loginUser = (req, res, next) => {
  // this req.rowCount is coming from the checkUserExists func which is passed just before this func
  if (req.rowCount > 0) {
    var jwtToken = jwt.sign({ id: req.UserId }, process.env.JWT_SECRET_KEY, {
      expiresIn: "1y",
    });
    res.status(200).json({
      message: "Login Success",
      token: jwtToken,
    });
  } else {
    // if rowCount is 0 means the user not exists but as someone can directly access my api endpoint so rather than showing 'user not exists' im showing 'UnAuthorized' as someone trying to login through api will enter the spotify_id manually
    res.status(401).json({
      message: "UnAuthorized",
    });
  }
};

exports.updateUserProfile = async (req, res, next) => {
  try {
    const requiredParams = [
      "first_name",
      "last_name",
      "dob",
      "age",
      "phone_num",
    ];
    const missingParams = requiredParams.filter(
      (param) => req.body[param] === undefined
    );

    if (missingParams.length > 0) {
      // Send a message to the user indicating which parameters are missing
      res.status(400).json({
        missing_parameters: `${missingParams.join(", ")}`,
      });
    } else {
      var { rowCount } = await pool.query(
        "update users set first_name=$1 , last_name=$2 , phone_num=$3 , dob=$4 , age=$5 where id=$6",
        [
          req.body.first_name,
          req.body.last_name,
          req.body.phone_num,
          req.body.dob,
          req.body.age,
          req.body.userId,
        ]
      );
      if (rowCount === 0) {
        res.status(500).json({
          message: "something unexpected occured",
        });
        return;
      }
      res.status(200).json({
        message: "updated successfully",
      });
    }
  } catch (error) {
    var errur = new Error("Server error");
    errur.status = 500;
    errur.stack = error;
    next(errur);
  }
};

exports.getUserProfile = async (req, res, next) => {
  try {
    var { rows } = await pool.query(
      "select first_name,last_name,dob,phone_num,profile_pic_url,age from users where id=$1",
      [req.body.userId]
    );
    res.status(200).json({
      details: rows[0],
    });
  } catch (error) {
    var err = new Error("Something Unexpected Occured");
    err.stack = error;
    err.status = 500;
    next(err);
  }
};

exports.checkUserPhoneNum = async (req, res, next) => {
  try {
    var { rowCount } = await pool.query(
      "select id from users where phone_num=$1",
      [req.body.phone_num]
    );
    console.log(rowCount);
    if (rowCount > 0) {
      res.status(401).json({
        message: "User With same Phone Number Exists",
      });
    } else {
      res.status(200).json({
        message: "Success",
      });
    }
  } catch (error) {
    var err = new Error("Something Unexpected Occured");
    err.stack = error;
    err.status = 500;
    next(err);
  }
};

exports.updateProfilePic = async (req, res, next) => {
  try {
    var token = req.headers.authorization.split(" ")[1];
    var decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);
    var userId = decoded["id"];
    var { rows } = await pool.query(
      "select profile_pic_url from users where id=$1",
      [userId]
    );
    var old_profile_path = rows[0]["profile_pic_url"];
    var oldimagepath = old_profile_path.toString().split("\\").pop();
    const filePath = path.join(
      __dirname,
      "../../uploads/profile_pic",
      oldimagepath
    );
    fs.unlink(filePath, (err) => {
      if (err) {
        console.log(err);
      }
    });
    var { rowCount } = await pool.query(
      "update users set profile_pic_url =$1 where id=$2",
      ["http://192.168.0.105:9000/" + req.file.path, userId]
    );
    if (rowCount > 0) {
      res.status(200).json({
        message: "updated successfully",
      });
    } else {
      res.status(500).json({
        message: "server error",
      });
    }
  } catch (error) {
    var err = new Error("Something Unexpected Occured");
    err.stack = error;
    err.status = 500;
    next(err);
  }
};

// Sure, I can help you with that. Here’s an algorithm that calculates the similarity between
//the current user and other users based on their top artists and top genres:

// def similarity(current_user, other_users):
//     similarities = []
//     for user in other_users:
//         common_artists = set(current_user['top_artists']) & set(user['top_artists'])
//         common_genres = set(current_user['top_genres']) & set(user['top_genres'])
//         total_common = len(common_artists) + len(common_genres)
//         max_common = len(set(current_user['top_artists']) | set(user['top_artists'])) + len(set(current_user['top_genres']) | set(user['top_genres']))
//         similarity = total_common / max_common
//         similarities.append(similarity)
//     return similarities

// function similarity(current_user, other_users) {
//   let similarities = [];
//   for (let user of other_users) {
// let common_artists = new Set([...current_user['top_artists']].filter(x => new Set(user['top_artists']).has(x)));
//       let common_genres = new Set([...current_user['top_genres']].filter(x => new Set(user['top_genres']).has(x)));
//       let total_common = common_artists.size + common_genres.size;
//       let max_common = new Set([...current_user['top_artists'], ...user['top_artists']]).size + new Set([...current_user['top_genres'], ...user['top_genres']]).size;
//       let similarity = total_common / max_common;
//       similarities.push(similarity);
//   }
//   return similarities;
// }

// Copy
// This algorithm calculates the Jaccard similarity between the current user and other users based on their top artists and top genres.
// The Jaccard similarity is defined as the size of the intersection divided by the size of the union of the two sets.
// The resulting list contains the similarity scores between the current user and each of the other users.

// but what is set(current_user['top_artists']) my user['t_atist'] is a array so st(top_artsis) will cpnatin something like {[sdjkmm,hds]} so whats the meaning
// Sent message. but what is set(current_user['top_artists']) my user['t_atist'] is a array so st(top_artsis) will cpnatin something like {[sdjkmm,hds]} so whats the meaning
// set(current_user['top_artists']) creates a set from the list of top artists of the current user. A set is an unordered collection of unique elements. In this case, it is used to find the common artists between the current user and other users by performing set intersection (&) and set union (|) operations.

// For example, if the current user has a list of top artists ['A', 'B', 'C'] and another user has a list of top artists ['B', 'C', 'D'], then the set intersection of these two lists would be {'B', 'C'} and the set union would be {'A', 'B', 'C', 'D'}. The Jaccard similarity between these two users based on their top artists would be len({'B', 'C'}) / len({'A', 'B', 'C', 'D'}) = 2/4 = 0.5.

// I hope this clarifies your doubt. Let me know if you have any further questions.
exports.getFriends = async (req, res, next) => {
  const id = req.body.userId;
  console.log(id);
  try {
    const { rows } = await pool.query(
      "select song_stats.user_id,song_stats.top_artists,song_stats.top_genre,users.first_name,users.last_name,users.sex,users.age from song_stats inner join  users on song_stats.user_id=users.id where song_stats.user_id=$1",
      [id]
    );
    requestedUser = rows[0];
    const otherUsers = await pool.query(
      "select song_stats.user_id,song_stats.top_artists,song_stats.top_genre,users.first_name,users.last_name,users.sex,users.age,users.profile_pic_url from song_stats inner join  users on song_stats.user_id=users.id where song_stats.user_id!=$1 order by id desc", //ORDER BY random()
      [id]
    );

    const newListOfusers = [];
    for (let user of otherUsers.rows) {
      let common_artists = new Set(
        [...requestedUser["top_artists"]].filter((x) =>
          new Set(user["top_artists"]).has(x)
        )
      );
      let common_genres = new Set(
        [...requestedUser["top_genre"]].filter((x) =>
          new Set(user["top_genre"]).has(x)
        )
      );
      let total_common = common_artists.size + common_genres.size;
      let max_common =
        new Set([...requestedUser["top_artists"], ...user["top_artists"]])
          .size +
        new Set([...requestedUser["top_genre"], ...user["top_genre"]]).size;
      let similarity = total_common / max_common;
      user["song_similarity"] = similarity * 100;
      newListOfusers.push(user);
    }
    res.status(200).json({
      friends: newListOfusers,
    });
  } catch (error) {
    var err = new Error("Something Unexpected Occured");
    err.stack = error;
    err.status = 500;
    next(err);
  }
};

exports.getUsersUnreadMsgs = async (req, res, next) => {
  try {
    const id = req.body.userId;
    const { rowCount } = await pool.query(
      "select messages.id from messages join users on messages.to_user_id=users.id where users.id=$1 and messages.created_at>users.last_seen ",
      [id]
    );
    await pool.query("update messages set status=$1 where to_user_id=$2 and status!='read'",["delivered",id])
    res.status(200).json({
      count_of_unread_msgs: rowCount > 0 ? true : false,
    });
  } catch (error) {
    var err = new Error("Something Unexpected Occured");
    err.stack = error;
    err.status = 500;
    next(err);
  }
};
