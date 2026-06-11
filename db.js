const { Pool } = require('pg');

// Railway 会自动注入 DATABASE_URL（来自 Supabase 连接字符串）
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }   // Supabase 需要 SSL
});

pool.on('error', (err) => {
  console.error('数据库连接池错误:', err.message);
});

module.exports = pool;
