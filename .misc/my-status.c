/* Status for dwm on Linux - compile with -lX11 */

#define DELAY_SEC    5
#define TIME_FORMAT  "%a %d %b %H:%M"
#define TIME_LOCALE  "pt_BR.UTF-8"
#define LOAD_N       2  /* 1 to 1min, 2 to 5min, 3 to 15min load average */
#define BATTERY      "BAT1"
#define STATUS       get_load, get_battery, get_uptime, get_date
#define SEPARATOR    " | "
#define BUF_SIZE     64

#define _DEFAULT_SOURCE

#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <fcntl.h>
#include <unistd.h>
#include <sys/sysinfo.h>

#include <X11/Xlib.h>

#define LENGTH(arr) (sizeof(arr) / sizeof(arr[0]))

static Display *dpy;
static Window root_win;
static int cpu_n;
static int bat_status_fd, bat_capacity_fd;

static void
set_root_name(char *s)
{
	XStoreName(dpy, root_win, s);
	XSync(dpy, 0);
}

static char *
get_load(void)
{
	static char buf[BUF_SIZE];
	double loadavg[LOAD_N];

	if (getloadavg(loadavg, LOAD_N) != LOAD_N)
		return "l <error>";

	snprintf(buf, sizeof(buf), "l %3.2f", loadavg[LOAD_N-1] / cpu_n);
	return buf;
}

static char *
get_battery(void)
{
	static char buf[BUF_SIZE];
	ssize_t ret, off;

	if (bat_status_fd == -1 || bat_capacity_fd == -1)
		return NULL;

	ret = pread(bat_status_fd, buf, 3, 0);
	if (ret == -1)
		return "bat <error>";
	off = ret;

	buf[0] += 32;
	buf[off++] = ' ';

	ret = pread(bat_capacity_fd, buf+off, 3, 0);
	if (ret == -1)
		return "bat <error>";
	for (ret += off; off < ret && buf[off] > ' '; ++off);

	buf[off++] = '%';
	buf[off++] = '\0';

	return buf;
}

static char *
get_uptime(void)
{
	static char buf[BUF_SIZE];
	static int count = 0;
	struct sysinfo inf;
	int hour, min;

	if (count == 0) {
		if (sysinfo(&inf) == -1)
			return "up <error>";
		hour = inf.uptime / 3600;
		min = inf.uptime % 3600 / 60;
		snprintf(buf, sizeof(buf), "up %02d:%02d", hour, min);
	}

#if 60 % DELAY_SEC == 0
	count = (count + DELAY_SEC) % 60;
#endif

	return buf;
}

static char *
get_date(void)
{
	static char date[BUF_SIZE];
	time_t now;

	now = time(0);
	strftime(date, sizeof(date), TIME_FORMAT, localtime(&now));
	return date;
}

static char *(*status_funcs[])(void) = { STATUS };

static char status[(BUF_SIZE + sizeof(SEPARATOR)-1) * LENGTH(status_funcs)];

int
main(void)
{
	size_t i, len;
	char *s;
	int ret;

	setlocale(LC_TIME, TIME_LOCALE);

	dpy = XOpenDisplay(0);
	if (!dpy) {
		fprintf(stderr, "Can't open display\n");
		return 1;
	}

	root_win = DefaultRootWindow(dpy);

	for (i = 0; i < LENGTH(status_funcs); ++i) {
		if (status_funcs[i] == get_load) {
			cpu_n = get_nprocs();
		} else if (status_funcs[i] == get_battery) {
			bat_status_fd = open("/sys/class/power_supply/" BATTERY "/status", O_RDONLY);
			bat_capacity_fd = open("/sys/class/power_supply/" BATTERY "/capacity", O_RDONLY);
		}
	}

	for (;;) {
		for (i = len = 0; i < LENGTH(status_funcs); ++i) {
			s = status_funcs[i]();
			if (!s)
				continue;
			ret = snprintf(
					status+len,
					sizeof(status)-len,
					i == 0 ? "%s" : SEPARATOR "%s",
					s);
			if (ret <= 0)
				return 1;
			len += ret;
		}
		set_root_name(status);
		sleep(DELAY_SEC);
	}
}
