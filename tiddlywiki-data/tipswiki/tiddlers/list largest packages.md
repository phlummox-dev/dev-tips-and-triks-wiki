from [StackExchange](https://unix.stackexchange.com/questions/40442/which-installed-software-packages-use-the-most-disk-space-on-debian):


```
dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n
```
