#!/bin/bash

# Install Python 3 development requirements
#   -y automatically accepts prompts
sudo apt-get install build-essential libssl-dev libffi-dev python3-venv python3-dev -y

# Create a Python 3 virtual environment for this project using venv
#   -m imports the module and associated dependencies
#   No need to access these files from your host, so created outside of the shared directory
python3 -m venv /home/vagrant/venv

# Set venv environment variables
#   'export' creates an environment variable
#   Set when venv is activated
#   A settings file per environment, inheriting from a base settings file, is best practice (see Two Scoops)
echo "export DJANGO_SETTINGS_MODULE=config.settings.local" >> /home/vagrant/venv/bin/activate
#   Do not store your public environment secret keys in your repo!
echo "export DJANGO_SECRET_KEY=4hw83wf83f783g87f3fh9h39hf93fg78dyshd9shas9cslnlnpv9e9incnifurhw" >> /home/vagrant/venv/bin/activate

# Automatically activate the Python venv on 'vagrant ssh'
echo ". /home/vagrant/venv/bin/activate" >> ~/.profile

# Activate Python venv
. /home/vagrant/venv/bin/activate

# Upgrade to the latest version of pip
python -m pip install --upgrade pip

# Use pip to install project dependencies from the relevant requirements file
pip install -r /vagrant/requirements/local.txt

# Create a PostgreSQL role for the Vagrant user
sudo -u postgres bash -c "psql -c \"CREATE USER vagrant WITH PASSWORD 'vagrant' CREATEDB SUPERUSER;\""

# Create a database for the project
#   Replace with the name of your database
createdb DATABASE_NAME

# Run database migrations
#   Make sure this points to your manage.py file
#   Create your Django app before you allow this line to run
python src/manage.py migrate
