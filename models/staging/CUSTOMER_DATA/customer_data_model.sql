version: 2

models:
  - name: stg_customers
    description: "Cleaned and typed customer master data. One row per customer."
    columns:
      - name: customer_id
        description: "Primary key. Unique identifier for a customer."
        tests:
          - unique
          - not_null

  - name: stg_customer_feedbacks
    description: "Cleaned and typed customer feedback submissions. One row per feedback event."
    columns:
      - name: feedback_id
        description: "Primary key. Unique identifier for a feedback submission."
        tests:
          - unique
          - not_null
      - name: ticket_id
        description: "Foreign key to the ticket associated with this feedback."
        tests:
          - not_null
          