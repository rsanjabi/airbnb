{{ config(materialized='table') }}

WITH all_listings AS (
    SELECT * FROM {{ ref('all_available_listings') }}
),

flags AS (
    SELECT 
        {{ dbt_utils.surrogate_key(['listing_id', 'listing_report_date']) }}
                                                                AS listing_snapshot_key,
        -- High availablity means available more than 95 days per year
        iff(availability_365 > 95, True, False)                 AS high_avail_flag,
        -- Multi host means they have more than 1 listing
        iff(total_host_listings > 1, True, False)               AS multi_host_flag,
        -- Home flag means that the listing is for an entire home or apt.
        iff((room_type = 'Entire home/apt'), True, False)       AS home_flag,
        -- Frequently booked means it has had a review in last 6 months (from report date)
        -- AND (the number of reviews * minimum stay) annualized is > than 95 days
        CASE WHEN (listing_report_date < DATEADD(month, 6, last_review)
                       AND (min_nights*reviews_per_month*12)>95)
             THEN True
             ELSE False END                                     AS freq_book_flag
    FROM all_listings
)

SELECT * from flags