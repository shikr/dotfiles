import { Gtk } from 'ags/gtk4';
import { execAsync } from 'ags/process';

function Left() {
    return (
        <box $type="start" halign={Gtk.Align.START}>
            <button
                onClicked={() => execAsync('echo hello').then(console.log)}
                hexpand
            >
                <image iconName="start-here" />
            </button>
        </box>
    );
}

export default Left;
