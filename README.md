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


## Custom user model
* Create model
  * Base from **AbstractBaseUser** and **PermissionsMixin**
    * **AbstractBaseUser** contain functionality for auth system but don't contain any fields
    * **PermissionsMixin** contain functionality for the permissions and fields related to permissions
* Create custom manager
  * Used for CLI integration
* Set **AUTH_USER_MODEL** in **settings.py**
* Create and run migrations
* When using Docker, we may have to delete previously created volume to allow migrations to complete
  * Delete a volume with :
  ```shell 
  docker volume rm rest-api-backend_dev-db-data
  ```
* Common issues:
  * Running migrations before setting custom model
  * Typos in config
  * Indentation in manager or model


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

## Database flow
* Configure PostgresSQL service 
* Set Django configuration
* Handled race condition, make sure DB is ready
* (Add migrations commands to Docker compose)
* (Update GitHub actions)

# Django Admin
* UI to update data through models
* Enabled per model
* Inside **admin.py**
  * **admin.site.register** 
* Customisable
  * Create class based off **ModelAdmin** or **UserAdmin**
  * Override/set class variables
  * Create **fieldsets**, **readonly_fields**, **add_fieldsets**, etc. to control layout of admin page
  


## Tips
* When using **@patch(...)** for mocking behaviours, the argument to be used in the function/class which is targeted by patch work from left to right, starting from the nearest bottom patch to the upper patch on the right.
* Create a new user model on every Django project to make it easier to customise later or, for example, using email instead of username 
* It's good practice to use **from django.utils.translation import gettext_lazy as _** to prepare translation for future needs in project 