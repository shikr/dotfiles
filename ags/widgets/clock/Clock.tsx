import { createSettings, createState } from 'ags';
import { createPoll } from 'ags/time';
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';

const TIME_FORMAT = {
    '24h': '%R',
    '12h': '%I:%M %p',
};

type TimeKey = keyof typeof TIME_FORMAT;

const getTime = (clockFormat: string) => {
    const format =
        clockFormat in TIME_FORMAT
            ? TIME_FORMAT[clockFormat as TimeKey]
            : TIME_FORMAT['12h'];

    return GLib.DateTime.new_now_local().format(format)!;
};

function Clock() {
    const gsettings = Gio.Settings.new('org.gnome.desktop.interface');
    const { clockFormat } = createSettings(gsettings, {
        'clock-format': 's',
    });
    const tooltip = createPoll('', 1000, ['date', '+%A %d %B %Y']);
    const [time, setTime] = createState(getTime(clockFormat.get()));

    clockFormat.subscribe(() => setTime(getTime(clockFormat.get())));

    setInterval(() => setTime(getTime(clockFormat.get())), 1000);

    return <label label={time} tooltipText={tooltip} class="clock" />;
}

export default Clock;
