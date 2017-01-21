#!/usr/bin/env python
import os
import sys

if __name__ == "__main__":
	
	if 'DJANGO_SETTINGS_MODULE' not in os.environ:
		raise ImproperlyConfigured("Cannot find environment variable DJANGO_SETTINGS_MODULE.")
	else:
		from django.core.management import execute_from_command_line
		execute_from_command_line(sys.argv)
