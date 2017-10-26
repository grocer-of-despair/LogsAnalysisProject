# Ruairi's Logs Analysis Project
A Python programming to query a database for results

## Description
This is Project 3 for the Udacity Full Stack Nanodegree. I was required to to build a reporting tool that queries a database to answer a series of questions.

### Primary Features
- [x] Designed to run in the command line
- [x] Written using Python3
- [x] Code conforms to the PEP8 style recommendations.
- [x] Connects to and queries an SQL Database
- [x] A `README` file includes details of the project.


### Requirements
This requires [psycopg2](http://initd.org/psycopg/) to run.

Install the dependencies:

```
$ pip install psycopg2
```

Connect to the Database:
```
$ psql -d news
```
Create the Database Views required:
```
create view TotalViewsByStatus as select path, count(*) from log group by path;

create view StatusCount as select cast(time as date), status, count(*) from log group by status,cast(time as date) order by cast(time as date);

```

### How to run this project
 * Install [Python](https://www.python.org/) (Python 3 recommended)
 * Clone this repository `git clone https://github.com/grocer-of-despair/NanodegreeMovieDatabase`
 * Run `QueryNewsDatabase.py` from the cloned project directory: `python3 QueryNewsDatabase.py`

## License
The contents of this repository are covered under the [GNU GENERAL PUBLIC LICENSE](LICENSE.txt).
