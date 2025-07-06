import { Gtk } from 'ags/gtk4';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import Clock from '../clock/Clock';

function NotificationsButton() {
    return (
        <BarButton>
            <Clock />
            <BarPopover>
                <box orientation={Gtk.Orientation.VERTICAL} class="vertical">
                    <Gtk.Calendar />
                </box>
            </BarPopover>
        </BarButton>
    );
}

export default NotificationsButton;
