
# issues

# issue

original instructions through the following error:

```
configure.ac:26: error: required file 'src/buildconfig.h.in' not found
```

fixed doing this before the bootstrap.sh

```
./autogen.sh
```


```
packet_device.type11 (remote-exec): ./configure: line 5935: syntax error near unexpected token `CHECK,'
packet_device.type11 (remote-exec): ./configure: line 5935: `PKG_CHECK_MODULES(CHECK, check >= 0.9.7, have_check="yes", { $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: Check not found; cannot run unit tests!" >&5'
packet_device.type11 (remote-exec): make: *** No targets specified and no makefile found.  Stop.
packet_device.type11 (remote-exec): cp: cannot stat ‘statsite’: No such file or directory
```

# issue

packet_device.type11 (remote-exec): Setting up dbus (1.6.18-0ubuntu4.4) ...

packet_device.type11 (remote-exec): Configuration file '/etc/dbus-1/system.conf'
packet_device.type11 (remote-exec):  ==> File on system created by you or by a script.
packet_device.type11 (remote-exec):  ==> File also in package provided by package maintainer.
packet_device.type11 (remote-exec):    What would you like to do about it ?  Your options are:
packet_device.type11 (remote-exec):     Y or I  : install the package maintainer's version
packet_device.type11 (remote-exec):     N or O  : keep your currently-installed version
packet_device.type11 (remote-exec):       D     : show the differences between the versions
packet_device.type11 (remote-exec):       Z     : start a shell to examine the situation
packet_device.type11 (remote-exec):  The default action is to keep your current version.
packet_device.type11 (remote-exec): *** system.conf (Y/I/N/O/D/Z) [default=N] ?

# solution

DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install couchdb


# notes


atom + terraform
```
apm install language-terraform
```
