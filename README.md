Automation Scheduler
====================

WMFO - Tufts Freeform Radio  
ops@wmfo.org  
For copyrights and licensing, see COPYING.  

The Automation Scheduler pulls songs at random from our Rivendell library and
generates log files for use as automated playback, one song every two minutes.
Settings in Rivendell (`rdlogmanager`) merge the log with PSAs and IDs at
designated points in the hour. Logs are loaded and unloaded using macro carts,
see [Rivendell-Spinitron Update] (https://github.com/WMFO/Rivendell-Spinitron-Update/blob/master/macro-carts.txt).
Logs can be viewed with `rdlogedit`.

Rivendell's internal scheduler is O(n^2) in the number of songs in the library.
By making simplifying assumptions about the uniformity of songs selected, this
scheduler is O(n). Third parties are encouraged to modify the sql statement in
the .cpp file to sample songs according to their preferences. Ours selects
songs flagged as CLEAN and excludes a few genres.

The scheduler is run daily thanks to this entry in root's crontab:
`0 15 * * * /opt/wmfo/scheduler/logs/generate_log.sh`

**Combatibility note:** Somewhere between Rivendell 2.1.5 and 2.2.1, the
interface of `rdlogmanager` was changed so that the argument to the `-d` flag
is now n+1 days in the future. The current version works with 2.2.1 and has
been tested with 2.8.1.

The provided Makefile builds and installs the scheduler. It also changes file
ownership to lock down files with the mysql credentials. To build, you'll need
MySQL++: `sudo apt-get install "libmysql++-dev"`.

Changelog
---------
###4/23/12
Last modification to source prior to source control. - Ben Yu

###11/30/12
Minimal modifications to remove credentials. - Max Goldstein

###11/30/12
Add Makefile. - Max Goldstein

###12/20/12
Change `generate_log.sh` to work with new `rdlogmanager` interface. Look for SAFE scheduler code. - Max Goldstein

###6/10/13
SQL query enhancements: exclude metal and similar (we use the `USER_DEFINED` field for genre), check for validity. - Max Goldstein

###5/6/14
Abstract out restricting genres. - Max Goldstein
