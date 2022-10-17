# Rest-API-Backend

## Run tests through Docker
```shell
docker-compose run --rm app sh -c "python manage.py test"
```

## Flow to add apps in django
* Run 
```shell
docker-compose run --rm app sh -c "python manage.py startapp appName"  
```
* Add app to **INSTALLED_APPS** in **settings.py** file in main directory

## Flow to add management command to Django
* In specific app create a **management** directory with an **__init__.py** file inside
* Inside this new directory create a **commands** directory with also an **__init__.py** file
* With this file structure Django automatically detect that files in that directory are management commands (ex: *wait_for_db.py* in *core* app)
* Run it in Docker with 
```shell
docker-compose run --rm app sh -c "python manage.py command_name"
```

## Flow for ORM
* Define Models
* Generate migrations files (ensure app is enabled in **settings.py) 
```shell
 python manage.py makemigrations
```
* Setup database (run migrations)
```shell
python manage.py migrate
```
* Store data

## Models 
* Each model maps to a table
* Models contain
  * Name
  * Fields
  * Other metadata
  * Custom Python logic


## Tips
* When using **@patch(...)** for mocking behaviours, the argument to be used in the function/class which is targeted by patch work from left to right, starting from the nearest bottom patch to the upper patch on the right.