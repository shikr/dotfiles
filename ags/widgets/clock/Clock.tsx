import { Gtk } from 'ags/gtk4';
import { createPoll } from 'ags/time';

function Clock() {
    const date = createPoll('', 1000, ['date', '+%d/%m/%y']);
    const time = createPoll('', 1000, ['date', '+%I:%M %p']);
    const tooltip = createPoll('', 1000, ['date', '+%A %d %B %Y']);

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
