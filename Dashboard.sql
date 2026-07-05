	SELECT
        payment_id,
        user_id,
        TO_CHAR(created_at, 'YYYY-MM-DD HH24:MI:SS') AS created_at,
        payment_type,
        grand_total,
        status,
        package_id,
        package_name,
        package_type,
        category,
        cluster_id,
        cluster_name,
        tier,
        cluster_type,
        counseling_type
    FROM core.vw_payment_report
