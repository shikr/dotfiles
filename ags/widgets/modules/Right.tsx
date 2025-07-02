import { Gtk } from 'ags/gtk4';
import { createPoll } from 'ags/time';

function Right() {
    const time = createPoll('', 1000, 'date');

    return (
        <box $type="end" halign={Gtk.Align.END}>
            <menubutton hexpand>
                <label label={time} />
                <popover>
                    <Gtk.Calendar />
                </popover>
            </menubutton>
        </box>
    );
}

export default Right;
