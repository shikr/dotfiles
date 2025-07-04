import { createSettings, createState } from 'ags';
import { Gtk } from 'ags/gtk4';
import { exec } from 'ags/process';
import { createPoll } from 'ags/time';
import Gio from 'gi://Gio';

const TIME_FORMAT = {
    '24h': '%R',
    '12h': '%I:%M %p',
};

type TimeKey = keyof typeof TIME_FORMAT;

const getFormat = (format: string) => [
    'date',
    '+' +
        (format in TIME_FORMAT
            ? TIME_FORMAT[format as TimeKey]
            : TIME_FORMAT['12h']),
];

function Clock() {
    const gsettings = Gio.Settings.new('org.gnome.desktop.interface');
    const { clockFormat } = createSettings(gsettings, {
        'clock-format': 's',
    });
    const date = createPoll('', 1000, ['date', '+%d/%m/%y']);
    const tooltip = createPoll('', 1000, ['date', '+%A %d %B %Y']);
    const [time, setTime] = createState(exec(getFormat(clockFormat.get())));

    setInterval(() => setTime(exec(getFormat(clockFormat.get()))), 1000);

    return (
        <box
            orientation={Gtk.Orientation.VERTICAL}
            spacing={0}
            tooltipText={tooltip}
            class="clock"
        >
            <label label={date} />
            <label label={time} />
        </box>
    );
}

export default Clock;
