import GObject from 'ags/gobject';
import { Gtk } from 'ags/gtk4';
import AstalNotifd from 'gi://AstalNotifd';
import { getIconType } from '../../../utils/theme';
import EntryIcon from '../../common/EntryIcon';

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

    if (wicon === false)
        wicon = (
            <EntryIcon
                entry={notification.desktopEntry}
                appName={notification.appName}
                iconSize={Gtk.IconSize.LARGE}
            />
        );

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
