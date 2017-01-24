# vagrant-django-postgres

Beginner-friendly starter files for a vagrant box running Django with PostgreSQL.

This assumes you've seperated requirements and settings into `local, test, staging, production` as in Two Scoops, and that your Django project root is `src`. You'll have to make a couple of minor changes if not.

## System Dependencies

* [VirtualBox with Guest Additions](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* `vagrant plugin install vagrant-vbguest`
* `vagrant plugin install vagrant-librarian-chef-nochef`
* Windows only: [Git](https://git-scm.com/download/win), for using `vagrant ssh` on Windows easily

## Configuration

The following environment variables are required, and taken care of by vagrant provisioning:

* `DJANGO_SETTINGS_MODULE=config.settings.local`
* `DJANGO_SECRET_KEY=YOUR_KEY`

Before first run:

* In `Vagrantfile`, set your `Project Configuration for Vagrant`
* In `bash/django_setup.sh`, replace `DATABASE_NAME` and set your `DJANGO_SECRET_KEY`

## Usage

### First Run

1. `vagrant up` _to start the VM and run initial provisioning_
2. `python src/manage.py createsuperuser` _to create a Django superuser_
3. vagrant reload` _to restart following the updates installed during provisioning_

### Subsequent Runs

1. `vagrant up`
2. `vagrant ssh`

### Shell

* Use `python src/manage.py runserver 0.0.0.0:8000` to start the server.
* Append `--settings=config.settings.local` to use a particular settings file.
