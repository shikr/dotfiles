import { createConnection, With } from 'ags';
import { Gtk } from 'ags/gtk4';
import AstalNotifd from 'gi://AstalNotifd';
import MonitorContext from '../../app/MonitorContext';
import Notification from './Notification';

function NotificationLog() {
    const { geometry } = MonitorContext.use();
    const notifd = AstalNotifd.get_default();
    const notifications = createConnection(
        notifd.get_notifications(),
        [notifd, 'notified', () => notifd.get_notifications()],
        [notifd, 'resolved', () => notifd.get_notifications()]
    );

    return (
        <box
            orientation={Gtk.Orientation.VERTICAL}
            class="vertical"
            spacing={4}
        >
            <box class="horizontal">
                <button
                    hexpand
                    halign={Gtk.Align.END}
                    class="raised"
                    sensitive={notifications(n => n.length > 0)}
                    onClicked={() =>
                        notifications.get().forEach(n => n.dismiss())
                    }
                >
                    Dismiss All
                </button>
            </box>
            <With
                value={notifications(notis =>
                    notis.sort((a, b) => b.time - a.time)
                )}
            >
                {(notifications: AstalNotifd.Notification[]) =>
                    notifications.length > 0 && (
                        <scrolledwindow
                            propagateNaturalHeight
                            maxContentHeight={geometry.height / 4}
                        >
                            <box
                                orientation={Gtk.Orientation.VERTICAL}
                                class="vertical"
                            >
                                {notifications.map(notif => (
                                    <Notification
                                        notification={notif}
                                        close={() => notif.dismiss()}
                                    />
                                ))}
                            </box>
                        </scrolledwindow>
                    )
                }
            </With>
        </box>
    );
}

export default NotificationLog;
