const {Pool} = require('pg')

// const databaseConfig = {connectionString: process.env.DATABASE_URL}
const pool = new Pool({
    user:process.env.DB_USER,
    host:process.env.DB_HOST,
    password:process.env.DB_PASSWORD,
    port:process.env.DB_PORT,
    max:process.env.MAX_CONNECTION,
    database:process.env.DATABASE
});

module.exports = pool;