# FI Cost Center Expense Tracker

A custom SAP ABAP application for tracking departmental expenses against cost center budgets.

Built entirely on custom Z-tables.

---

## What It Does

A company has multiple departments (cost centers), each with an annual budget. Throughout the year, expenses are posted against those cost centers. This application lets a user filter expenses by cost center, date range, and approval status — then displays the results in an ALV Grid report showing how much of each budget has been used.

---

## Technologies Used

- **SE11** — Custom domains, data elements, and Z-tables
- **CDS View Entity** — Built in Eclipse ADT with association, calculated KPIs, and semantic annotations
- **Dynpro / Module Pool** — Selection screen with filters
- **ALV Grid** — Report output using `CL_GUI_ALV_GRID` with traffic-light color logic
- **FI/CO Domain** — Cost centers, budgets, expense postings

---

## Key Features

- Two custom Z-tables: cost center master data + expense transactions
- CDS View calculates budget utilization %, remaining budget, and expense count
- ALV Grid highlights rows by utilization: green (healthy), yellow (warning), red (over limit)
- Selection screen filters by cost center, posting date range, and approval status

---

## Screenshots

> To be added after system testing.

---

## Related Projects

- [sap-flight-cds-analytics](https://github.com/jordanovskiigor/sap-flight-cds-analytics) — CDS View Entity for flight analytics with associations and KPIs
