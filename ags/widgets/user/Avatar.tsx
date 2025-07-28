import { Accessor } from 'ags';
import { Gtk } from 'ags/gtk4';
import AccountsService from 'gi://AccountsService';
import Adw from 'gi://Adw';
import Gio from 'gi://Gio';

interface Props {
    user: AccountsService.User;
    displayName: Accessor<string>;
}

function Avatar({ user, displayName }: Props) {
    return (
        <Adw.Avatar
            $={self => {
                const setAvatar = (avatar: string) =>
                    !Boolean(avatar)
                        ? self.set_custom_image(null)
                        : self.set_custom_image(
                              Gtk.IconPaintable.new_for_file(
                                  Gio.File.new_for_path(avatar),
                                  24,
                                  1
                              )
                          );
                setAvatar(user.iconFile);

                user.connect('changed', () => setAvatar(user.iconFile));
            }}
            text={displayName}
            showInitials
            size={24}
        />
    );
}

export default Avatar;
