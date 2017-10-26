create view TotalViewsByStatus as select path, count(*) from log group by path;

create view StatusCount as select cast(time as date), status, count(*) from log group by status,cast(time as date) order by cast(time as date);
