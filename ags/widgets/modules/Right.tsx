import { Gtk } from 'ags/gtk4';
import NotificationsButton from '../notification/NotificationsButton';
import PanelButton from '../panel/PanelButton';
import Tray from '../tray/Tray';

function Right() {
    return (
        <box $type="end" class="horizontal" halign={Gtk.Align.END} spacing={4}>
            <Tray />
            <PanelButton />
            <NotificationsButton />
        </box>
    );
}

export default Right;
