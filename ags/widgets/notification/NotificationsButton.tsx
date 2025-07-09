import { Gtk } from 'ags/gtk4';
import BarButton from '../bar/BarButton';
import BarPopover from '../bar/BarPopover';
import Clock from '../clock/Clock';
import NotificationLog from './NotificationLog';

function NotificationsButton() {
    return (
        <BarButton>
            <Clock />
            <BarPopover>
                <box
                    orientation={Gtk.Orientation.VERTICAL}
                    class="vertical"
                    spacing={4}
                >
                    <NotificationLog />
                    <Gtk.Calendar />
                </box>
            </BarPopover>
        </BarButton>
    );
}

export default NotificationsButton;
