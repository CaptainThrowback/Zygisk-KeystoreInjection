LIST="/data/adb/keystoreinjection/targetlist"

# Error on < Android 11.
if [ "$API" -lt 30 ]; then
    abort "- !!! You can't use this module on Android < 11"
fi

# safetynet-fix module is obsolete and it's incompatible with PIF.
if [ -d /data/adb/modules/safetynet-fix ]; then
    rm -rf /data/adb/modules/safetynet-fix
    rm -f /data/adb/SNFix.dex
    ui_print "! safetynet-fix module will be removed. Do NOT install it again along PIF."
fi

# MagiskHidePropsConf module is obsolete in Android 8+ but it shouldn't give issues.
if [ -d /data/adb/modules/MagiskHidePropsConf ]; then
    ui_print "! WARNING, MagiskHidePropsConf module may cause issues with PIF."
fi

# Check custom fingerprint
if [ -f "/data/adb/keystoreinjection/pif.json" ]; then
    mv -f "/data/adb/keystoreinjection/pif.json" "/data/adb/keystoreinjection/pif.json.old"
    ui_print "- Backup old pif.json"
fi

mkdir -p /data/adb/keystoreinjection
if [ ! -e "$LIST" ]; then
    echo "com.google.android.gms" > "$LIST"
    echo "io.github.vvb2060.keyattestation" >> "$LIST"
fi

ui_print "***********************************************************************"
ui_print "- Please move keybox to /data/adb/keystoreinjection/keybox.xml"
ui_print "- Please define target apps in /data/adb/keystoreinjection/targetlist"
ui_print "-     Format: one app per line"
ui_print "***********************************************************************"
