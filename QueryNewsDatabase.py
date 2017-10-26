#! /usr/bin/env python
import psycopg2  # Import database system

# Outline the Query strings to be used to retrieve the answers
query1 = '''select title, sum(count)
            from
                (select articles.title, TotalViewsByStatus.count
                from articles
                join TotalViewsByStatus on TotalViewsByStatus.path
                like '%'||articles.slug||'%'
                order by TotalViewsByStatus.count desc) as top3
            group by title order by sum desc limit 3;'''

query2 = '''select AandT.name as AuthorName, sum(toparticles.count)
            as TotalTotalViewsByStatus
            from
                (select authors.name, articles.title
                from authors
                full join articles on authors.id=articles.author)as AandT
            join
                (select articles.title, TotalViewsByStatus.count
                from articles
                join TotalViewsByStatus on TotalViewsByStatus.path
                like '%'||articles.slug||'%'
                order by TotalViewsByStatus.count desc) as toparticles
            on AandT.title=toparticles.title
            group by AandT.name
            order by TotalTotalViewsByStatus desc;'''

query3 = '''select StatusCount.time,
            (cast((StatusCount.count * 100 / StatusTotal.sum)
                as numeric(36,2)))
            as Percentage from StatusCount
            join (select sum(count), time
            from StatusCount group by time)
            as StatusTotal on StatusCount.time=StatusTotal.time
            where StatusCount.status='404 NOT FOUND'
            and (StatusCount.count * 100 / StatusTotal.sum) > 1;'''


# Connect to the database and fetch results
def connect(query):
    try:
        # Connect to the Database
        database = psycopg2.connect(database="news")
        # cursor runs queries and fetches results
        c = database.cursor()
        # execute queries above from the cursor
        c.execute(query)
        # fetch results from the cursor
        query_results = c.fetchall()
        database.close()
        return query_results
    except BaseException:
        print("Sorry, unable to fetch results from Database")


# Function to Print Our Results
def print_results(query_results):
    # Iterate over the rows and get our results
    for i in query_results:
        print('"' + i[0] + '"' + ' -- ' + str(int(i[1])) + ' Views')
    print('\n')


# !!Create the Views as instructed in the README file first!!

# Question 1: What are the most popular three articles of all time?
def print_popular_articles():
    print("The Most Popular Articles:")
    print('\n')

    popular_articles = connect(query1)
    print_results(popular_articles)


# Question 2: Who are the most popular article authors of all time?
def print_popular_authors():
    print("The Most Popular Authors:")
    print('\n')

    popular_articles = connect(query2)
    print_results(popular_articles)


# Question 3: On which days did more than 1% of requests lead to errors?
def print_error_requests():
    print('''Days on which more than 1% of requests lead to errors:''')
    print('\n')

    error_request = connect(query3)
    for i in error_request:
        print(i[0].strftime('%B %d, %Y') + ' -- ' + str(float(i[1])) + '%')
    print('\n')


# Run all 3 functions when executed
if __name__ == "__main__":

    print('\n')
    print_popular_articles()
    print_popular_authors()
    print_error_requests()
