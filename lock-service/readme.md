reference:
https://wiki.archlinux.org/title/Power_management#Sleep_hooks

lock.service
when you open the lid of your laptop
after suspend
the screen flashes and then locks.

To prevent that, enable this service.
Assuming that you already have
a locker like xss-lock enabled.
Put the service file into /etc/systemd/system/
Enable the service
