const aws = require('aws-sdk');
const express = require('express');
const multer = require('multer');
const multerS3 = require('multer-s3');
const uuid = require('uuid').v4;
const path = require('path');
require("dotenv").config()
const app = express();
const bucketname = process.env.BUCKETNAME
const s3 = new aws.S3({ apiVersion: '2006-03-01' });
// Needs AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

const upload = multer({
    storage: multerS3({
        s3,
        bucket: bucketname,
        metadata: (req, file, cb) => {
            cb(null, { fieldName: file.fieldname });
        },
        key: (req, file, cb) => {
            const ext = path.extname(file.originalname);
            cb(null, `${uuid()}${ext}`);
        }
    })
});

app.use(express.static('public'))

app.post('/upload', upload.array('avatar'), (req, res) => {
    return res.json({ status: 'OK', uploaded: req.files.length });
});


app.get("/list", async (req, res) => {

    let r = await s3.listObjectsV2({ Bucket: bucketname }).promise();
    let x = r.Contents.map(item => item.Key);
    res.send(x)
})


app.get("/download/:filename", async (req, res) => {
    const filename = req.params.filename
    let x = await s3.getObject({ Bucket: bucketname, Key: filename }).promise();
    res.send(x.Body)
})

app.get("/delete/:filename", async (req, res) => {
    const filename = req.params.filename
    await s3.deleteObject({ Bucket: bucketname, Key: filename }).promise();
    res.send("File Deleted Successfully")

})

app.listen(3001, () => console.log('App is listening...'));