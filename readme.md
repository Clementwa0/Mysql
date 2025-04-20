
# 📘 Intro to MySQL — Learning Notes

Welcome to the **MySQL Notes Repository**! This guide summarizes key SQL concepts and syntax using examples, suitable for beginners and revision before exams or interviews.

---

## 📚 What is Data?

- **Data**: A collection of facts such as numbers, words, measurements, or descriptions.
- **Types of Data**:
  - **Structured**: Organized in rows and columns (e.g., databases).
  - **Semi-structured**: Not strictly tabular but with some structure (e.g., JSON, XML).
  - **Unstructured**: No format (e.g., images, videos).

---

## 🗃️ What is a Database?

A **database** is an organized collection of structured data, usually stored electronically.

### 🔑 Key Components:
- **Tables**: Store data in rows and columns.
- **Rows**: Individual records.
- **Columns**: Attributes of data.
- **Schema**: Logical structure of the database.
- **Primary Key**: Uniquely identifies each record.
- **Foreign Key**: References a primary key in another table.
- **Index**: Speeds up data retrieval.
- **View**: A virtual table based on a query.
- **Stored Procedure**: Predefined SQL code stored in the DB.

---

## 🗂️ Data Models

| Model Type | Description |
|------------|-------------|
| Hierarchical | Tree-like structure (single parent, multiple children) |
| Network | Graph structure (multiple relationships) |
| Relational | Tabular structure with relations between tables |
| Object-Oriented | Data as objects, similar to OOP |

---

## 🔍 SQL Queries & Clauses

### 🧾 `SELECT` Statement

```sql
SELECT column1, column2 FROM table_name;
SELECT * FROM table_name;
```

### 🔎 `WHERE` Clause

```sql
SELECT * FROM SalesDB WHERE amount > 1000;
SELECT * FROM SalesDB WHERE category LIKE '%A%';
SELECT * FROM SalesDB WHERE event_date BETWEEN '2023-01-01' AND '2023-12-31';
```

### 🔠 `ORDER BY` Clause

```sql
SELECT * FROM SalesDB ORDER BY amount DESC;
SELECT * FROM SalesDB ORDER BY amount DESC, category ASC;
```

### 🔂 `DISTINCT`

```sql
SELECT DISTINCT category FROM SalesDB;
```

---

## ✍️ Data Manipulation

### ➕ `INSERT`

```sql
INSERT INTO table_name (column1, column2) VALUES (value1, value2);
```

### ✏️ `UPDATE`

```sql
UPDATE table_name SET column1 = value1 WHERE condition;
```

### ❌ `DELETE`

```sql
DELETE FROM table_name WHERE condition;
```

---

## 🔐 ACID Properties

| Property     | Description |
|--------------|-------------|
| Atomicity    | All or nothing execution |
| Consistency  | Maintains valid state |
| Isolation    | Prevents concurrent interference |
| Durability   | Changes persist after commit |

---

## 📊 Aggregations

| Function | Description |
|----------|-------------|
| `COUNT()` | Count rows |
| `SUM()` | Total sum |
| `AVG()` | Average |
| `MAX()` | Highest value |
| `MIN()` | Lowest value |

```sql
SELECT COUNT(*) FROM students;
SELECT AVG(Studage) AS average_age FROM students;
```

---

## 🧮 Grouping & Filtering

### 🔗 `GROUP BY`

```sql
SELECT Studage, COUNT(*) AS number_of_students
FROM students
GROUP BY Studage;
```

### 🧹 `HAVING`

```sql
SELECT Studage, COUNT(*) AS number_of_students
FROM students
GROUP BY Studage
HAVING COUNT(*) > 1;
```

---

## ⚠️ Handling NULLs

```sql
SELECT * FROM students WHERE Studage IS NULL;
SELECT * FROM students WHERE Studage IS NOT NULL;
```

---

## 🏆 Sample Challenge Query

**Show total payment amount per date (Top 5 recent):**

```sql
SELECT paymentDate, SUM(amount) AS total_amount
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate DESC
LIMIT 5;
```

---

## ✅ Summary

These notes provide a strong foundation in SQL. Practice regularly using sample data and real-world scenarios for best results.
