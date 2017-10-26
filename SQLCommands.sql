create view AandT as select authors.name, articles.title from authors full join articles on authors.id=articles.author;


create view TotalViewsByStatus as select path, count(*) from log group by path;

select articles.title, TotalViewsByStatus.count from articles join (select path, count(*) from log group by path) as TotalViewsByStatus on TotalViewsByStatus.path like '%'||articles.slug||'%'
  order by TotalViewsByStatus.count desc;
create view top3 as select articles.title, TotalViewsByStatus.count from articles join TotalViewsByStatus on TotalViewsByStatus.path like '%'||articles.slug||'%'
  order by TotalViewsByStatus.count desc;


select title, sum(count) from top3 group by title order by sum desc limit 3;
##
create view TotalViewsByStatus as select path, count(*) from log group by path;
****** Top 3 Articles *******
select title, sum(count) from (select articles.title, TotalViewsByStatus.count from articles join TotalViewsByStatus on TotalViewsByStatus.path like '%'||articles.slug||'%'
  order by TotalViewsByStatus.count desc) as top3 group by title order by sum desc limit 3;
******


select articles.title, TotalViewsByStatus.count from articles join TotalViewsByStatus on TotalViewsByStatus.path like '%'||articles.slug||'%'
  order by TotalViewsByStatus.count desc;

create view TopArticles as select articles.title, TotalViewsByStatus.count from articles join TotalViewsByStatus on TotalViewsByStatus.path like '%'||articles.slug||'%'
    order by TotalViewsByStatus.count desc;

! Top Authors
select AandT.name, sum(toparticles.count) from AandT join toparticles on AandT.title=toparticles.title group by AandT.name;

***** Descending Author Total TotalViewsByStatus *****
select AandT.name as AuthorName, sum(toparticles.count) as TotalTotalViewsByStatus from
(select authors.name, articles.title from authors full join articles on authors.id=articles.author) as AandT
join (select articles.title, TotalViewsByStatus.count from articles join TotalViewsByStatus on TotalViewsByStatus.path like '%'||articles.slug||'%'
    order by TotalViewsByStatus.count desc) as toparticles on AandT.title=toparticles.title group by AandT.name order by TotalTotalViewsByStatus desc;
*****

create view StatusCount as select cast(time as date), status, count(*) from log group by status,cast(time as date) order by cast(time as date);

select StatusCount.time, StatusCount.status, StatusCount.count, StatusTotal.sum,
(StatusCount.count * 100 / StatusTotal.sum) as Percentage from StatusCount
join (select sum(count), time from StatusCount group by time) as StatusTotal on StatusCount.time=StatusTotal.time where StatusCount.status='404 NOT FOUND' and (StatusCount.count * 100 / StatusTotal.sum) > 1;

select StatusCount.time, 
(cast((StatusCount.count * 100 / StatusTotal.sum) as numeric(36,2))) as Percentage from StatusCount
join (select sum(count), time from StatusCount group by time) as StatusTotal on StatusCount.time=StatusTotal.time
where StatusCount.status='404 NOT FOUND' and (StatusCount.count * 100 / StatusTotal.sum) > 1;
