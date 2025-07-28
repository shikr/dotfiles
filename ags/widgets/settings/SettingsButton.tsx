import { createBinding } from 'ags';
import { Gtk } from 'ags/gtk4';
import Gio from 'gi://Gio';
import { Settings } from '../../utils/settings';

function SettingsButton() {
    const settings = Settings.get_default();
    const styles = Gtk.StringList.new(['default', 'floating']);
    const positions = Gtk.StringList.new(['top', 'bottom']);

    const imageFilter = Gtk.FileFilter.new();
    imageFilter.add_mime_type('image/png');
    imageFilter.add_mime_type('image/jpeg');

    const dialog = new Gtk.FileDialog({
        title: 'Select the bar icon',
        filters: Gtk.FilterListModel.new(null, imageFilter),
    });

    Gio._promisify(Gtk.FileDialog.prototype, 'open', 'open_finish');

    return (
        <menubutton
            iconName="settings-symbolic"
            cssClasses={['flat', 'image-button']}
        >
            <popover>
                <box
                    class="vertical"
                    orientation={Gtk.Orientation.VERTICAL}
                    spacing={6}
                >
                    <box class="horizontal" spacing={4}>
                        <label
                            label="Style:"
                            halign={Gtk.Align.START}
                            hexpand
                        />
                        <Gtk.DropDown
                            model={styles}
                            selected={createBinding(settings, 'style').as(
                                style => styles.find(style)
                            )}
                            onNotifySelected={source =>
                                (settings.style = styles.get_string(
                                    source.selected
                                )! as Settings['style'])
                            }
                        />
                    </box>
                    <box class="horizontal" spacing={4}>
                        <label
                            label="Position:"
                            halign={Gtk.Align.START}
                            hexpand
                        />
                        <Gtk.DropDown
                            model={positions}
                            selected={createBinding(settings, 'position').as(
                                position => positions.find(position)
                            )}
                            onNotifySelected={source =>
                                (settings.position = positions.get_string(
                                    source.selected
                                )! as Settings['position'])
                            }
                        />
                    </box>
                    <box class="horizontal" spacing={4}>
                        <label label="Icon:" halign={Gtk.Align.START} />
                        <entry
                            hexpand
                            text={createBinding(settings, 'icon')}
                            onNotifyText={source =>
                                (settings.icon = source.text)
                            }
                        />
                        <button
                            class="image-button"
                            iconName="photo-symbolic"
                            onClicked={() =>
                                dialog
                                    .open(null, null)
                                    .then(file => {
                                        if (file !== null)
                                            settings.icon =
                                                file.get_path() ??
                                                settings.icon;
                                    })
                                    .catch((err: Gtk.DialogError) =>
                                        err.code !== 2
                                            ? console.error(err)
                                            : err
                                    )
                            }
                        />
                    </box>
                </box>
            </popover>
        </menubutton>
    );
}

export default SettingsButton;
