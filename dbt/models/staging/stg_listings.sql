WITH source AS (

    SELECT *
    FROM loading.raw_listings

), intermediate AS (

    SELECT
        id                                      AS listing_id,
        name                                    AS listing_name,
        host_id,
        host_name,
        neighborhood_group,
        neighborhood,
        latitude,
        longitude,
        roomt_type                              AS room_type,
        price,
        min_nights,
        number_of_reviews,
        last_review,
        reviews_per_month,
        total_host_lis                          AS total_host_listings,
        availability_365,
        city                                    AS listing_city,
        UPPER(REGEXP_REPLACE(city,' ',''))      AS standard_city,
        scrape_date

    FROM source

)

SELECT *
FROM intermediate
