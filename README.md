# Rest-API-Backend

## Run tests through Docker
* ```sh docker-compose run --rm app sh -c "python manage.py test"```

## Flow to add apps in django
* Run ```sh  docker-compose run --rm app sh -c "python manage.py startapp appName"  ```
* Add app to **INSTALLED_APPS** in **settings.py** file in main directory

## Flow to add management command to Django
* In specific app create a **management** directory with an **__init__.py** file inside
* Inside this new directory create a **commands** directory with also an **__init__.py** file
* With this file structure Django automatically detect that files in that directory are management commands (ex: *wait_for_db.py* in *core* app)
* Run it in Docker with ```sh docker-compose run --rm app sh -c "python manage.py command_name"```

## Tips
* When using **@patch(...)** for mocking behaviours, the argument to be used in the function/class which is targeted by patch work from left to right, starting from the nearest bottom patch to the upper patch on the right.