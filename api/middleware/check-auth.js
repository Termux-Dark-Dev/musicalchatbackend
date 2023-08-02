const jwt = require("jsonwebtoken");

exports.authUser = async (req, res, next) => {
  try {
    if (
      req.headers.authorization &&
      req.headers.authorization.startsWith("Bearer ")
    ) {
      var token = req.headers.authorization.split(" ")[1];
      var decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);
      var userId = decoded["id"];
      req.body.userId = userId;
      next();
    } else {
      var err = new Error("UnAuthorized");
      err.status = 401;
      next(err);
    }
  } catch (error) {
    var err = new Error("UnAuthorized");
    err.status = 401;
    next(err);
  }
};
