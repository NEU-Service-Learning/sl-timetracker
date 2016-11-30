# -*- coding: utf-8 -*-
# Generated by Django 1.10 on 2016-11-30 22:19
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='College',
            fields=[
                ('name', models.CharField(max_length=200, primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'College',
            },
        ),
        migrations.CreateModel(
            name='CommunityPartner',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
            ],
            options={
                'db_table': 'Community_Partner',
            },
        ),
        migrations.CreateModel(
            name='Course',
            fields=[
                ('id', models.CharField(max_length=8, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=200)),
            ],
            options={
                'db_table': 'Course',
            },
        ),
        migrations.CreateModel(
            name='Department',
            fields=[
                ('name', models.CharField(max_length=45, primary_key=True, serialize=False)),
                ('college', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.College')),
            ],
            options={
                'db_table': 'Department',
            },
        ),
        migrations.CreateModel(
            name='Enrollment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_active', models.BooleanField()),
                ('crn', models.CharField(max_length=5)),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.Course')),
            ],
            options={
                'db_table': 'Enrollment',
            },
        ),
        migrations.CreateModel(
            name='Project',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=45, null=True)),
                ('start_date', models.DateField(blank=True, null=True)),
                ('end_date', models.DateField(blank=True, null=True)),
                ('description', models.TextField(blank=True, null=True)),
                ('longitude', models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ('latitude', models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ('community_partner', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.CommunityPartner')),
                ('course', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='base.Course')),
            ],
            options={
                'db_table': 'Project',
            },
        ),
        migrations.CreateModel(
            name='Record',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField()),
                ('start_time', models.TimeField(blank=True, null=True)),
                ('total_hours', models.DecimalField(decimal_places=2, max_digits=4)),
                ('longitude', models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ('latitude', models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ('is_active', models.BooleanField()),
                ('comments', models.TextField(blank=True, null=True)),
                ('extra_field', models.CharField(blank=True, max_length=45, null=True)),
            ],
            options={
                'db_table': 'Record',
            },
        ),
        migrations.CreateModel(
            name='RecordCategory',
            fields=[
                ('name', models.CharField(max_length=45, primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'Record_Category',
            },
        ),
        migrations.CreateModel(
            name='Semester',
            fields=[
                ('name', models.CharField(max_length=45, primary_key=True, serialize=False)),
                ('start_date', models.DateField()),
                ('end_date', models.DateField()),
                ('is_active', models.BooleanField()),
            ],
            options={
                'db_table': 'Semester',
            },
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('role', models.CharField(max_length=100)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.AddField(
            model_name='record',
            name='category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.RecordCategory'),
        ),
        migrations.AddField(
            model_name='record',
            name='enrollment',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.Enrollment'),
        ),
        migrations.AddField(
            model_name='record',
            name='project',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.Project'),
        ),
        migrations.AddField(
            model_name='enrollment',
            name='semester',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.Semester'),
        ),
        migrations.AddField(
            model_name='enrollment',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='course',
            name='department',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='base.Department'),
        ),
    ]
