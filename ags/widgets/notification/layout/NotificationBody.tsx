import GObject from 'ags/gobject';
import { Gtk } from 'ags/gtk4';
import Adw from 'gi://Adw';
import AstalNotifd from 'gi://AstalNotifd';
import Gio from 'gi://Gio';
import Pango from 'gi://Pango';
import { getIconType } from '../../../utils/theme';

interface Props {
    notification: AstalNotifd.Notification;
}

function NotificationBody({ notification }: Props) {
    let image: GObject.Object | false = false;

    if (notification.image) {
        const imageType = getIconType(notification.image);
        if (imageType === 'file')
            image = (
                <Adw.Clamp
                    maximumSize={64}
                    orientation={Gtk.Orientation.VERTICAL}
                >
                    <Gtk.Picture
                        file={Gio.File.new_for_path(notification.image)}
                        contentFit={Gtk.ContentFit.COVER}
                    />
                </Adw.Clamp>
            );
        else if (imageType === 'icon')
            image = (
                <image
                    iconName={notification.image}
                    iconSize={Gtk.IconSize.LARGE}
                    pixelSize={64}
                />
            );
    }

    return (
        <box class="horizontal" hexpand spacing={4}>
            {image}
            <box orientation={Gtk.Orientation.VERTICAL} class="vertical">
                <label
                    class="title-4"
                    maxWidthChars={30}
                    halign={Gtk.Align.START}
                    label={notification.summary}
                    ellipsize={Pango.EllipsizeMode.END}
                />
                {Boolean(notification.body) && (
                    <label
                        wrap
                        maxWidthChars={30}
                        halign={Gtk.Align.START}
                        label={notification.body}
                    />
                )}
            </box>
        </box>
    );
}

export default NotificationBody;
