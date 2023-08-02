const express = require("express");
const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/profile_pic");
  },
  filename: (req, file, cb) => {
    cb(
      null,
      file.fieldname + "-" + Date.now() + "." + file.mimetype.split("/")[1]
    );
  },
});

const fileFilter = (req, file, cb) => {
  // reject a file
  if (file.mimetype === "image/jpeg" || file.mimetype === "image/png" || file.mimetype === "image/jpg") {
    cb(null, true);
  } else {
    var error = new Error("Unsupported file type")
    error.status = 415
    cb(error, false);
  }
};

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5,
  },
  fileFilter: fileFilter,
});

const userController = require("../controller/user");
const {authUser} = require('../middleware/check-auth')

const router = express.Router();

router.post("/signup", upload.single("profile_pic"), userController.signUpUser);
router.post("/login", userController.checkUserExists, userController.loginUser);
router.post("/updateProfile",authUser, userController.updateUserProfile);
router.get("/getProfile",authUser, userController.getUserProfile);
router.post("/checkNum", userController.checkUserPhoneNum);
router.post("/updateProfilePic",[authUser,upload.single("updated_profile_pic")],userController.updateProfilePic)
router.get("/me/friends",authUser, userController.getFriends);
router.get("/me/unread/msgs",authUser, userController.getUsersUnreadMsgs);
// router.get("/me/msgs/with/:otherUserId",authUser, userController.getMyMsgsWithOtherUser);

module.exports = router;
