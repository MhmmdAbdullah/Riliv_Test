-- ============================================================
-- SOAL 3 — 3 Penjualan Paket Tertinggi per packageType
-- Tampilkan 3 paket dengan total penjualan tertinggi pada
-- masing-masing packageType, dari seluruh periode. Status success.
-- ============================================================

WITH ranked AS (
    -- Tahap 1: hitung total revenue per (packageType, nama paket),
    -- sekaligus beri ranking di dalam masing-masing packageType.
    SELECT
        dp.package_type AS "packageType",
        dp.name AS packages,
        SUM(fp.grand_total) AS "totalSuccessPayments",
        ROW_NUMBER() OVER (
            PARTITION BY dp.package_type              -- reset ranking tiap ganti packageType
            ORDER BY SUM(fp.grand_total) DESC          -- urutkan dari revenue terbesar
        ) AS rn
    FROM core.fact_payments fp
    LEFT JOIN core.dim_packages dp
        ON fp.package_id = dp.package_id
        -- LEFT JOIN sengaja dipakai di sini karena ada packageId
        -- di fact_payments yang orphan (tidak match ke dim_packages).
        -- Baris ini tetap harus muncul sebagai [NULL] sesuai
        -- expected output, bukan hilang begitu saja.
    WHERE fp.status = 'success'
    GROUP BY dp.package_type, dp.name
)
-- Tahap 2: filter hasil tahap 1, ambil ranking 1-3 saja per packageType.
SELECT *
FROM ranked
WHERE rn <= 3
ORDER BY "packageType" NULLS LAST, rn;