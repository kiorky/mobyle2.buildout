#!/usr/bin/env python
# -*- coding: utf-8 -*-
__docformat__ = 'restructuredtext en'

from apex.models import create_user
for i in range(1000):
    create_user(username='test_%s'%i,
                password='my_password',
                email='kiorky+%s@gmail.com'%i,
                active='Y')

# vim:set et sts=4 ts=4 tw=80:
