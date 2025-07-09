import { createState, For } from 'ags';
import { Astal, Gdk, Gtk } from 'ags/gtk4';
import app from 'ags/gtk4/app';
import AstalNotifd from 'gi://AstalNotifd';
import GLib from 'gi://GLib';
import Notification from './Notification';

// TODO: use https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.ToastOverlay.html
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
                if (n.has(id)) clearTimeout(n.get(id)!);
                return new Map([
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
                    ...n.entries(),
                ]);
            });
    });

    const removeNotification = (id: number) =>
        setNotifications(n => {
            if (n.has(id)) clearTimeout(n.get(id)!);
            return new Map(Array.from(n.entries()).filter(([k]) => k !== id));
        });

    notifd.connect('resolved', (_, id) => removeNotification(id));

    return (
        <window
            name="notifications"
            visible={notifications(n => n.size > 0)}
            defaultHeight={-1}
            defaultWidth={-1}
            gdkmonitor={gdkmonitor}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
            application={app}
        >
            <box
                orientation={Gtk.Orientation.VERTICAL}
                class="vertical"
                spacing={4}
            >
                <For each={notifications(n => Array.from(n.keys()))}>
                    {id => (
                        <Gtk.Frame class="app-notification">
                            <Notification
                                notification={notifd.get_notification(
                                    id as number
                                )}
                                close={() => removeNotification(id as number)}
                            />
                        </Gtk.Frame>
                    )}
                </For>
            </box>
        </window>
    );
}

export default NotificationWindow;
