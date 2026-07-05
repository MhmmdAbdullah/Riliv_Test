-- ============================================================
-- SOAL 1 — Top Spender User
-- Tampilkan userId dengan total pengeluaran (spend) tertinggi,
-- dihitung dari seluruh periode waktu. Hanya transaksi status success.
-- ============================================================
 
SELECT
    user_id AS "userId",
    SUM(grand_total) AS "totalSpend"
FROM core.fact_payments
WHERE status = 'success'          -- hanya hitung transaksi yang sukses
GROUP BY user_id                  -- kelompokkan per user, gabungkan semua transaksinya
ORDER BY "totalSpend" DESC        -- urutkan dari spend tertinggi ke terendah
LIMIT 10;                         -- ambil 10 teratas sesuai expected output