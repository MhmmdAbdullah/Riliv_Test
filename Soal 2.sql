-- ============================================================
-- SOAL 2 — Total Penjualan per Cluster per Tahun
-- Urutkan berdasarkan tahun (ascending), lalu total penjualan
-- tertinggi (descending) dalam tahun tersebut. Hanya status success.
-- ============================================================

SELECT
    EXTRACT(YEAR FROM fp.created_at)::int AS year,   -- ambil tahun dari created_at
    dc.name AS cluster,
    SUM(fp.grand_total) AS "totalSuccessPayments"
FROM core.fact_payments fp
JOIN core.dim_packages dp
    ON fp.package_id = dp.package_id
JOIN core.dim_clusters dc
    ON dp.cluster_id = dc.cluster_id
    -- JOIN biasa (bukan LEFT JOIN) sengaja dipakai di sini:
    -- paket bertipe 'meditasi' yang cluster_id-nya NULL memang
    -- harus dikecualikan, sesuai expected output yang tidak
    -- menampilkan baris meditasi sama sekali.
WHERE fp.status = 'success'
GROUP BY year, dc.name
ORDER BY year ASC, "totalSuccessPayments" DESC;