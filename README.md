# Ruairi's Logs Analysis Project
A Python programming to query a database for results

## Description
This is Project 3 for the Udacity Full Stack Nanodegree. I was required to to build a reporting tool that queries a database to answer a series of questions.

### Primary Features
- [x] Designed to run in the command line
- [x] Written using Python3
- [x] Page adheres to HTML/CSS Formatting and Style Guidelines.
- [x] Code is ready for personal review and neatly formatted.
- [x] Portfolio meets the Seperation of Concerns and File Structure Specifications.
- [x] A `README` file includes details of all the project.
### Primary Features
- [x] Dynamically generated from a Python data structure.
- [x] Page presents movie title, box art and trailer link.
- [x] Code is ready for personal review and neatly formatted.
- [x] Page is error free.
- [x] Code is ready for personal review and neatly formatted.
- [x] Comments effectively explain longer code procedures.
- [x] A `README` file includes details of all the steps required to successfully run the application.

### Extras
- Uses Python to query IMDB API for movie information.
- Includes a link to each movie's IMDB Page
- Includes a link to the projects GitHub Repository

### Requirements
This requires [psycopg2](http://initd.org/psycopg/) to run.

Install the dependencies:

```
$ pip install psycopg2
```

Connect to the Database:
```
psql -d news
```
Create the Database Views required:
```
create view TotalViewsByStatus as select path, count(*) from log group by path;

create view StatusCount as select cast(time as date), status, count(*) from log group by status,cast(time as date) order by cast(time as date);

```

### How to run this project
 * Install [Python](https://www.python.org/) (Python 3 recommended)
 * Clone this repository `git clone https://github.com/grocer-of-despair/NanodegreeMovieDatabase`
 * Run `entertainment_centre.py` from the cloned project directory: `python entertainment_centre.py`
 * Enjoy Fresh Tomatoes

## License
The contents of this repository are covered under the [GNU GENERAL PUBLIC LICENSE](LICENSE.txt).
