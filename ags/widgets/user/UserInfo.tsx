import { createState, With } from 'ags';
import { Gtk } from 'ags/gtk4';
import AccountsService from 'gi://AccountsService';
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';
import Avatar from './Avatar';

function UserInfo() {
    const username = GLib.get_user_name();
    const userManager = AccountsService.UserManager.get_default();
    // Load all users
    userManager.list_users();
    const user = userManager.get_user(username);
    const [displayName, setDisplayName] = createState(
        user.realName || username
    );
    const [icon, setIcon] = createState(user.iconFile);
    const [textName, setTextName] = createState(user.realName);

    const imageFilter = Gtk.FileFilter.new();
    imageFilter.add_mime_type('image/png');
    imageFilter.add_mime_type('image/jpeg');

    const dialog = new Gtk.FileDialog({
        title: 'Select your avatar',
        filters: Gtk.FilterListModel.new(null, imageFilter),
    });

    Gio._promisify(Gtk.FileDialog.prototype, 'open', 'open_finish');

    const avatarOptions = [
        {
            label: 'Select',
            action: () =>
                dialog
                    .open(null, null)
                    .then(file =>
                        user.set_icon_file(file?.get_path() ?? user.iconFile)
                    )
                    .catch((err: Gtk.DialogError) =>
                        err.code !== 2 ? console.error(err) : err
                    ),
        },
        {
            label: 'Remove',
            action: () => user.set_icon_file(''),
        },
    ];

    user.connect(
        'changed',
        () => (
            setDisplayName(user.realName || user.userName),
            setIcon(user.iconFile)
        )
    );

    return (
        <menubutton class="flat" onMap={() => setTextName(user.realName)}>
            <box class="horizontal" spacing={6}>
                <Avatar user={user} displayName={displayName} />
                <label class="body" label={displayName} />
            </box>
            <popover>
                <box class="horizontal" spacing={6}>
                    <menubutton>
                        <With value={icon}>
                            {(file: string) =>
                                Boolean(file) &&
                                GLib.file_test(file, GLib.FileTest.EXISTS) ? (
                                    <image pixelSize={64} file={file} />
                                ) : (
                                    <image
                                        pixelSize={64}
                                        iconName="avatar-default-symbolic"
                                    />
                                )
                            }
                        </With>
                        <popover>
                            <Gtk.ListBox
                                selectionMode={Gtk.SelectionMode.NONE}
                                class="boxed-list"
                                onRowActivated={(_, row) => {
                                    if (row !== null)
                                        avatarOptions[row.get_index()].action();
                                }}
                            >
                                {avatarOptions.map(({ label }) => (
                                    <label label={label} />
                                ))}
                            </Gtk.ListBox>
                        </popover>
                    </menubutton>
                    <box
                        class="vertical"
                        valign={Gtk.Align.CENTER}
                        orientation={Gtk.Orientation.VERTICAL}
                    >
                        <label
                            class="heading"
                            label="Real Name:"
                            halign={Gtk.Align.START}
                        />
                        <box class="horizontal" spacing={6}>
                            <entry
                                text={textName}
                                onNotifyText={source =>
                                    setTextName(source.text)
                                }
                            />
                            <button
                                label="Apply"
                                onClicked={() =>
                                    user.set_real_name(textName.get())
                                }
                            />
                        </box>
                    </box>
                </box>
            </popover>
        </menubutton>
    );
}

export default UserInfo;
