import GObject from 'ags/gobject';
import { Gtk } from 'ags/gtk4';
import AstalNotifd from 'gi://AstalNotifd';
import Gio from 'gi://Gio';
import { getIconType } from '../../../utils/theme';

interface Props {
    notification: AstalNotifd.Notification;
    close: () => unknown;
}

function NotificationHeader({ notification, close }: Props) {
    const getWidget = (icon: string | undefined) => {
        if (icon !== undefined) {
            const iconType = getIconType(icon);
            if (iconType === 'icon')
                return <image iconName={icon} iconSize={Gtk.IconSize.LARGE} />;
            else if (iconType === 'file')
                return <image file={icon} iconSize={Gtk.IconSize.LARGE} />;
        }
        return false;
    };

    let wicon: GObject.Object | false = getWidget(
        notification.appIcon || undefined
    );

    if (wicon === false && notification.desktopEntry) {
        const icon =
            Gio.DesktopAppInfo.new_from_filename(notification.desktopEntry)
                ?.get_icon()
                ?.to_string() ?? undefined;

        wicon = getWidget(icon);
    }
    if (wicon === false && notification.appName) {
        const apps = Gio.DesktopAppInfo.search(notification.appName).flat();

        for (const app of apps) {
            const icon =
                Gio.DesktopAppInfo.new(app)?.get_icon()?.to_string() ??
                undefined;

            const w = getWidget(icon);
            if (w !== false) {
                wicon = w;
                break;
            }
        }
    }

    return (
        <box class="horizontal" hexpand spacing={4}>
            {wicon}
            <label
                label={notification.appName}
                halign={Gtk.Align.START}
                hexpand
                class="heading"
            />
            <button
                halign={Gtk.Align.END}
                onClicked={() => close()}
                cssClasses={['flat', 'circular', 'image-button']}
                iconName={'window-close-symbolic'}
            />
        </box>
    );
}

export default NotificationHeader;
