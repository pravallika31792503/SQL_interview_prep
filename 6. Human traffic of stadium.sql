-- Solution to display the records with three or more rows with consecutive id's, 
-- and the number of people is greater than or equal to 100 for each.
-- Return the result table ordered by visit_date in ascending order.
-- Write your MySQL query statement below
with prev_logic as (
    select id,visit_date,
    lag(people,2) over (order by id) as prevday2,
    lag(people,1) over(order by id) as prevday1,
    people,
    lead(people,2) over (order by id) as nxtday2,
    lead(people,1) over(order by id) as nxtday1
    from stadium
)
select
    id,
    visit_date,
    people
from prev_logic
where people>=100
and ((nxtday1>=100 and nxtday2>=100)or(prevday1>=100 and prevday2>=100)or (prevday1>=100 and nxtday1>=100))
