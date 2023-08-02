const pool = require('./configs/db')

exports.notificationListener = async ()=>{
    const client = await pool.connect()
    client.query("listen new_messages")
    client.on('notification',(notf)=>{
        console.log(notf.payload);
    })
}