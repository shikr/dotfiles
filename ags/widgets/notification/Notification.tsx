import { Gtk } from 'ags/gtk4';
import AstalNotifd from 'gi://AstalNotifd';
import NotificationAction from './layout/NotificationAction';
import NotificationBody from './layout/NotificationBody';
import NotificationHeader from './layout/NotificationHeader';

interface Props {
    notification: AstalNotifd.Notification;
    close: () => unknown;
}

function Notification({ notification, close }: Props) {
    const margin = 6;

    return (
        <box
            orientation={Gtk.Orientation.VERTICAL}
            overflow={Gtk.Overflow.VISIBLE}
            class="vertical"
            marginBottom={margin}
            marginEnd={margin}
            marginTop={margin}
            marginStart={margin}
            spacing={4}
        >
            <NotificationHeader notification={notification} close={close} />
            <Gtk.Separator
                orientation={Gtk.Orientation.HORIZONTAL}
                class="horizontal"
            />
            <NotificationBody notification={notification} />
            {notification.actions.length > 0 && (
                <box hexpand spacing={4} class="horizontal">
                    {notification.actions.map(action => (
                        <NotificationAction
                            action={action}
                            notification={notification}
                        />
                    ))}
                </box>
            )}
        </box>
    );
}

export default Notification;
