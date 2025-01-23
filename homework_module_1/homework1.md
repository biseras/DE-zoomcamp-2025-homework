## Homework 1

---

Codes or commands to answer questions for homework 1

---

### Question 1
Run docker with the python:3.12.8 image in an interactive mode, use the entrypoint bash.

What's the version of pip in the image?

- Execute `docker run -it --entrypoint=bash python:3.12.8 in terminal`
- Check the version inside the container by executing the following command `pip --version`
- The output is **24.3.1**

---

### Question 2
Given the following docker-compose.yaml, what is the hostname and port that pgadmin should use to connect to the postgres database?
Hostname and port: **postgres:5432** or **db:5432**

---

### Question 3
During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:

1. Up to 1 mile
```sql 
SELECT COUNT(*) AS trips_up_to_1_mile
FROM green_taxi_trip
WHERE lpep_pickup_datetime >= '2019-10-01' 
  AND lpep_dropoff_datetime < '2019-11-01'
  AND trip_distance <= 1; 
```
**104 802**
2. In between 1 (exclusive) and 3 miles (inclusive),
```sql 
SELECT COUNT(*) 
FROM green_taxi_trip
WHERE lpep_pickup_datetime >= '2019-10-01' 
  AND lpep_dropoff_datetime < '2019-11-01'
  AND trip_distance > 1 AND trip_distance <= 3;
``` 
**198 924**
3. In between 3 (exclusive) and 7 miles (inclusive),
```sql 
SELECT COUNT(*)
FROM green_taxi_trip
WHERE lpep_pickup_datetime >= '2019-10-01' 
  AND lpep_dropoff_datetime < '2019-11-01'
  AND trip_distance >3  AND trip_distance <= 7;
``` 
**109 603**
4. In between 7 (exclusive) and 10 miles (inclusive)
```sql 
SELECT COUNT(*)
FROM green_taxi_trip
WHERE lpep_pickup_datetime >= '2019-10-01' 
  AND lpep_dropoff_datetime < '2019-11-01'
  AND trip_distance > 7 AND trip_distance <= 10;
``` 
**27 678**
5. Over 10 miles
```sql 
SELECT COUNT(*)
FROM green_taxi_trip
WHERE lpep_pickup_datetime >= '2019-10-01' 
  AND lpep_dropoff_datetime < '2019-11-01'
  AND trip_distance > 10;
``` 
**35 189**

---

## Question 4
Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.
Tip: For every day, we only care about one single trip with the longest distance.
```sql 
SELECT lpep_pickup_datetime
FROM green_taxi_trip
WHERE trip_distance=(select MAX(trip_distance)
						from green_taxi_trip)
``` 
**2019-10-31 23:23:41**

---

## Question 5
Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?
Consider only lpep_pickup_datetime when filtering by date.
```sql 
SELECT z."Zone"
FROM green_taxi_trip as g JOIN taxi_zones as z on g."PULocationID" = z."LocationID" and g."DOLocationID" = z."LocationID"
WHERE g.lpep_pickup_datetime >= '2019-10-18 00:00:00'
AND g.lpep_pickup_datetime < '2019-10-19 00:00:00' and g.total_amount>13.000;
``` 

**East Harlem North, Morningside Heights**

---

## Question 6
For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip?
```sql 
SELECT z."Zone"
FROM green_taxi_trip as g JOIN taxi_zones as z on g."DOLocationID" = z."LocationID"
WHERE z."Zone"='East Harlem North'
ORDER BY g.tip_amount DESC
LIMIT 1;
``` 
**East Harlem North**

---

## Question 7
Which of the following sequences, respectively, describes the workflow for:

1. Downloading the provider plugins and setting up backend,
2. Generating proposed changes and auto-executing the plan
3. Remove all resources managed by terraform

- **terraform init, terraform apply -auto-approve, terraform destroy**

---







