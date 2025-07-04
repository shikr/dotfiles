import { Gtk } from 'ags/gtk4';
import AstalNotifd from 'gi://AstalNotifd';
import GLib from 'gi://GLib';
import Pango from 'gi://Pango';

interface Props {
    notification: AstalNotifd.Notification;
    close: () => unknown;
}

function Notification({ notification, close }: Props) {
    return (
        <box
            orientation={Gtk.Orientation.VERTICAL}
            halign={Gtk.Align.FILL}
            hexpand
        >
            <box halign={Gtk.Align.FILL} hexpand>
                <image
                    halign={Gtk.Align.START}
                    iconSize={Gtk.IconSize.NORMAL}
                    iconName={notification.appIcon}
                />
                <label
                    label={notification.appName}
                    halign={Gtk.Align.FILL}
                    hexpand
                />
                <button
                    halign={Gtk.Align.END}
                    onClicked={() => close()}
                    class="close"
                >
                    <image iconName="window-close-symbolic" />
                </button>
            </box>
            <Gtk.Separator orientation={Gtk.Orientation.HORIZONTAL} />
            <box hexpand>
                <label
                    ellipsize={Pango.EllipsizeMode.END}
                    hexpand
                    maxWidthChars={30}
                    halign={Gtk.Align.START}
                    label={notification.summary}
                />
                {(image => {
                    if (!image) return false;
                    if (new Gtk.IconTheme().has_icon(image))
                        return (
                            <image
                                halign={Gtk.Align.END}
                                iconName={image}
                                iconSize={Gtk.IconSize.LARGE}
                            />
                        );
                    if (GLib.file_test(image, GLib.FileTest.EXISTS))
                        return (
                            <image
                                halign={Gtk.Align.END}
                                file={image}
                                overflow={Gtk.Overflow.HIDDEN}
                                pixelSize={64}
                            />
                        );

                    return false;
                })(notification.image)}
            </box>
            <box orientation={Gtk.Orientation.VERTICAL}>
                <label
                    maxWidthChars={30}
                    wrap
                    hexpand={false}
                    halign={Gtk.Align.START}
                    label={notification.body}
                />
            </box>
            {notification.actions.length > 0 && (
                <box hexpand spacing={4}>
                    {notification.actions.map(({ label, id }) => (
                        <button
                            hexpand
                            onClicked={() => notification.invoke(id)}
                        >
                            <label label={label} halign={Gtk.Align.CENTER} />
                        </button>
                    ))}
                </box>
            )}
        </box>
    );
}

export default Notification;
