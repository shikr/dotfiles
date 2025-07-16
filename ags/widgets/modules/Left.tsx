import { Gtk } from 'ags/gtk4';
import AppsButton from '../apps/AppsButton';

function Left() {
    return (
        <box $type="start" class="horizontal" halign={Gtk.Align.START}>
            <AppsButton />
        </box>
    );
}

export default Left;
