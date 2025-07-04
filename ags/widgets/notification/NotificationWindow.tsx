import { createState, For } from 'ags';
import { Astal, Gdk, Gtk } from 'ags/gtk4';
import app from 'ags/gtk4/app';
import AstalNotifd from 'gi://AstalNotifd';
import GLib from 'gi://GLib';
import Notification from './Notification';

function NotificationWindow(gdkmonitor: Gdk.Monitor) {
    const notifd = AstalNotifd.get_default();
    const [notifications, setNotifications] = createState<
        Map<number, GLib.Source>
    >(new Map());

    notifd.connect('notified', (source, id) => {
        if (
            !notifd.dontDisturb ||
            source.get_notification(id).urgency === AstalNotifd.Urgency.CRITICAL
        )
            setNotifications(n => {
                if (n.has(id)) clearInterval(n.get(id)!);
                return new Map([
                    ...n.entries(),
                    [
                        id,
                        setTimeout(
                            () =>
                                setNotifications(
                                    n =>
                                        new Map(
                                            Array.from(n.entries()).filter(
                                                ([k]) => k !== id
                                            )
                                        )
                                ),
                            5000
                        ),
                    ],
                ]);
            });
    });

    const removeNotification = (id: number) =>
        setNotifications(n => {
            if (n.has(id)) clearInterval(n.get(id)!);
            return new Map(Array.from(n.entries()).filter(([k]) => k !== id));
        });

    notifd.connect('resolved', (_, id) => removeNotification(id));

    return (
        <window
            class="Notifications"
            visible={notifications(n => n.size > 0)}
            defaultHeight={-1}
            defaultWidth={-1}
            gdkmonitor={gdkmonitor}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
            application={app}
        >
            <box orientation={Gtk.Orientation.VERTICAL}>
                <For each={notifications(n => Array.from(n.keys()))}>
                    {id => (
                        <Notification
                            notification={notifd.get_notification(id as number)}
                            close={() => removeNotification(id as number)}
                        />
                    )}
                </For>
            </box>
        </window>
    );
}

export default NotificationWindow;
