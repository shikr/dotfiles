import { Gtk } from 'ags/gtk4';
import AstalNotifd from 'gi://AstalNotifd';

interface Props {
    action: AstalNotifd.Action;
    notification: AstalNotifd.Notification;
}

function NotificationAction({ action, notification }: Props) {
    return (
        <button
            hexpand
            onClicked={() => notification.invoke(action.id)}
            class="raised"
        >
            <label label={action.label} halign={Gtk.Align.CENTER} />
        </button>
    );
}

export default NotificationAction;
