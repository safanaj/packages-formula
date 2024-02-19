# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import packages with context %}

    {%- for package in packages.golang.goinstall %}

    {% if package is mapping %}

packages-golang-goinstall-{{ package }}-cmd-run:
  cmd.run:
    - name: go install {{ package.pkg }}
    - runas: {{ packages.rootuser }}
    {% if package.destdir %}
    - env:
      - GOBIN: {{ package.destdir }}
    {% endif %}

    {% else %}
packages-golang-goinstall-{{ package }}-cmd-run:
  cmd.run:
    - name: go install {{ package }}
    - runas: {{ packages.rootuser }}

    {% endif %}

    {%- endfor %}
