PREFIX = /usr/local

dwm_desktop = /usr/share/xsessions/dwm.desktop
st_desktop = $(PREFIX)/share/applications/st.desktop
dwmrun = $(PREFIX)/bin/dwmrun
x_kbd = /etc/X11/xorg.conf.d/00-keyboard.conf
x_amd = /etc/X11/xorg.conf.d/20-amdgpu.conf
x_intel = /etc/X11/xorg.conf.d/20-intel.conf

dwm: $(dwm_desktop) $(st_desktop) $(dwmrun)
kbd: $(x_kbd)
amd: $(x_amd)
intel: $(x_intel)

$(dwm_desktop): dwm.desktop
	cp dwm.desktop $(dwm_desktop)
	chmod 644 $(dwm_desktop)

$(st_desktop): st.desktop
	cp st.desktop $(st_desktop)
	chmod 644 $(st_desktop)

$(dwmrun): dwmrun
	cp dwmrun $(dwmrun)
	chmod 755 $(dwmrun)

$(x_kbd): 00-keyboard.conf
	cp 00-keyboard.conf $(x_kbd)
	chmod 644 $(x_kbd)

$(x_amd): 20-amdgpu.conf
	cp 20-amdgpu.conf $(x_amd)
	chmod 644 $(x_amd)

$(x_intel): 20-intel.conf
	cp 20-intel.conf $(x_intel)
	chmod 644 $(x_intel)
