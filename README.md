# Riliv Data Analytics Test

Repository ini berisi solusi untuk **Riliv Data Analytics Test**, yang mencakup query SQL untuk setiap soal, query pendukung dashboard, serta dataset hasil ekstraksi yang digunakan sebagai sumber visualisasi dashboard.

## Repository Structure

```text
.
├── Soal 1.sql
├── Soal 2.sql
├── Soal 3.sql
├── Dashboard.sql
├── payment_report.csv
└── README.md
```

## File Description

| File                   | Description                                                                                       |
| ---------------------- | ------------------------------------------------------------------------------------------------- |
| **Soal 1.sql**         | SQL query sebagai jawaban untuk Soal 1.                                                           |
| **Soal 2.sql**         | SQL query sebagai jawaban untuk Soal 2.                                                           |
| **Soal 3.sql**         | SQL query sebagai jawaban untuk Soal 3.                                                           |
| **Dashboard.sql**      | SQL query untuk menghasilkan dataset yang digunakan sebagai data source dashboard.                |
| **payment_report.csv** | Dataset hasil eksekusi `Dashboard.sql` yang digunakan untuk membangun dashboard di Looker Studio. |

---

## Dashboard

Dashboard dapat diakses melalui tautan berikut:

**https://datastudio.google.com/reporting/e06e5dc5-410b-4f40-a8ac-40a65c3b5c32**

---

## Database Schema

Seluruh query pada repository ini menggunakan **Star Schema** yang berada pada schema **`core`**.

### Mapping Table

Apabila database Anda menggunakan schema `public`, cukup:

* Hapus prefix `core.`
* Sesuaikan nama tabel menggunakan mapping berikut.

| Star Schema (`core`) | Schema `public` |
| -------------------- | --------------- |
| `core.fact_payments` | `payments`      |
| `core.dim_packages`  | `packages`      |
| `core.dim_clusters`  | `clusters`      |

---

## Query Adjustment Examples

### 1. Soal 1

**Before**

```sql
FROM core.fact_payments
```

**After**

```sql
FROM payments
```

---

### 2. Soal 2

**Before**

```sql
FROM core.fact_payments fp
JOIN core.dim_packages dp
ON fp.package_id = dp.package_id
```

**After**

```sql
FROM payments fp
JOIN packages dp
ON fp.package_id = dp.package_id
```

---

### 3. Soal 3

**Before**

```sql
FROM core.fact_payments fp
JOIN core.dim_clusters dc
ON fp.cluster_id = dc.cluster_id
```

**After**

```sql
FROM payments fp
JOIN clusters dc
ON fp.cluster_id = dc.cluster_id
```

---

### 4. Dashboard.sql

**Before**

```sql
FROM core.fact_payments fp
LEFT JOIN core.dim_packages dp
    ON fp.package_id = dp.package_id
LEFT JOIN core.dim_clusters dc
    ON fp.cluster_id = dc.cluster_id
```

**After**

```sql
FROM payments fp
LEFT JOIN packages dp
    ON fp.package_id = dp.package_id
LEFT JOIN clusters dc
    ON fp.cluster_id = dc.cluster_id
```

---

## Notes

* Seluruh query ditulis menggunakan **PostgreSQL**.
* Query pada repository ini menggunakan struktur **Star Schema (`core`)**.
* Jika menggunakan database dengan schema `public`, cukup hilangkan prefix `core.` dan sesuaikan nama tabel berdasarkan mapping yang telah dijelaskan.
* Dataset `payment_report.csv` merupakan hasil eksekusi dari `Dashboard.sql` dan digunakan sebagai data source untuk dashboard di Looker Studio.
